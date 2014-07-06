class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email_address(params[:email_address])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to videos_path
    elsif user
      render :new
      flash[:error] = "Password is incorrect"
    else
      render :new
      flash[:error] = "Email is incorrect"
    end
  end
end
