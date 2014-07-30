class UsersController < ApplicationController
  before_filter :require_user, only: :show  #### TODO Replace with CanCan
  before_filter :load_user, only: :show #### TODO Replace with load_resource

  def new
    @user = User.new
    @pre_filled_email = params[:pre_filled_email]
    @referral_token   = params[:referral_token]
  end

  def create
    referral_token = user_params[:referral_token]
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver
      create_relationship(referral_token, @user) if referral_token
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
    params.require(:user).permit(:email_address, :password, :full_name, :pre_filled_email, :referral_token)
  end

  def load_user
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @queue_items = @user.queue_items
  end

  def create_relationship(referral_token, new_user)
    referrer = User.find_by_referral_token referral_token
    Relationship.create(follower: new_user, followed_user: referrer)
    Relationship.create(follower: referrer, followed_user: new_user)
  end
end
