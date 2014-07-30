class PasswordResetController < ApplicationController
  def edit
    @user = User.find_by_token params[:id]

    if @user
      render :edit
    else
      flash[:error] = "That ain't no link I ever heard about"
      redirect_to home_path
    end
  end

  def update
    user = User.find_by_token password_reset_params[:reset_token]
    user.password = password_reset_params[:new_password]

    if user && user.save
      user.token = SecureRandom.urlsafe_base64(10)
      user.save(validate: false)
      #### TODO log user in
      flash[:success] = "You're password was reset. Maybe don't forget it again."
    else
      flash[:error] = "Something has gone wrong. You're password was not udpated"
    end

    redirect_to home_path
  end

  private

  def password_reset_params
    params.require(:password_reset).permit(:reset_token, :new_password)
  end
end
