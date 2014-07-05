class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(email_address:   params[:user][:email_address],
                     password_digest: params[:user][:password],
                     full_name:       params[:user][:full_name],
                    )
    if @user.save
      redirect_to signin_path
    else
      render :new
    end
  end
end
