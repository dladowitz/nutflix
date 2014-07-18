class SessionsController < ApplicationController
  def new
    redirect_to videos_path if current_user
  end

  def create
    @user = User.find_by_email_address(params[:email_address])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in"
      redirect_to videos_path
    elsif @user
      flash.now[:danger] = "Password is incorrect"
      render :new
    else
      flash.now[:danger] = "Email is incorrect"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:info] = "You have logged out"
    redirect_to home_path
  end
end
