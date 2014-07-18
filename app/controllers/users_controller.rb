class UsersController < ApplicationController
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

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :full_name)
  end
end
