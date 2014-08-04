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
      if invitation_token.present?
        invitation = find_invitation(invitation_token)
        create_relationship(invitation, @user)
      end

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

  def user_params
    params.require(:user).permit(:email_address, :password, :full_name, :invitation_token)
  end

  def load_user
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @queue_items = @user.queue_items
  end

  def find_invitation(token)
    invitation = Invitation.find_by_token token

    unless invitation
      flash[:error] = "Thats a forged invitation. Yerrrrrr outta here!"
      render :new
    end

    invitation
  end

  def create_relationship(invitation, new_user)
    inviter = invitation.inviter
    Relationship.create(follower: new_user, followed_user: inviter)
    Relationship.create(follower: inviter, followed_user: new_user)
  end
end
