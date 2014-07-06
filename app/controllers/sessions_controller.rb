class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email_address(params[:email_address])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in"
      redirect_to videos_path
    elsif user
      flash.now[:danger] = "Password is incorrect"
      render :new
    else
      flash.now[:danger] = "Email is incorrect"
      render :new
    end
  end
end
