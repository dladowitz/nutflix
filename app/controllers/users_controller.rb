class UsersController < ApplicationController
  before_filter :require_user, only: :show  #### TODO Replace with CanCan
  before_filter :load_user, only: :show #### TODO Replace with load_resource

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
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
    params.require(:user).permit(:email_address, :password, :full_name)
  end

  def load_user
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @queue_items = @user.queue_items
  end
end
