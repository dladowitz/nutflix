class UsersController < ApplicationController
  include Authenticate

  before_filter :require_user, only: :show  #### TODO Replace with CanCan
  before_filter :load_user, only: :show #### TODO Replace with load_resource

  def new
    @user = User.new
    @pre_filled_email = params[:pre_filled_email]
    @invitation_token = params[:invitation_token]
  end

  def create
    invitation_token = user_params[:invitation_token]
    @user = User.new(user_params.slice(:email_address, :password, :full_name))

    if @user.save
      UserMailer.delay.welcome_email(@user)

      create_relationship(invitation_token) if invitation_token.present?

      create_stripe_customer if params[:stripeToken]

      flash[:success] = "You have successfully created an account"
      redirect_to signin_path
    else
      render :new
    end
  end

  def show
    load_user
  end

  private

  def create_relationship(invitation_token)
    invitation = find_invitation(invitation_token)
    inviter = invitation.inviter

    Relationship.create(follower: @user, followed_user: inviter)
    Relationship.create(follower: inviter, followed_user: @user)
  end

  def create_stripe_customer
    StripeCustomerCreationWorker.perform_async(params[:stripeToken], @user.id)
  end

  def find_invitation(token)
    invitation = Invitation.find_by_token token

    unless invitation
      flash[:error] = "Thats a forged invitation. Yerrrrrr outta here!"
      render :new
    end

    return invitation
  end

  def load_user
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @queue_items = @user.queue_items
  end

  def camel_to_underscore_params(camel_params)
    underscore_params = {}
    camel_params.each{|key, value|  underscore_params[key.underscore.to_sym] = value}
    underscore_params
  end

  def user_params
    params.require(:user).permit(:email_address, :password, :full_name, :invitation_token)
  end
end
