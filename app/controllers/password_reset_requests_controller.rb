class PasswordResetRequestsController < ApplicationController
  def create
    user = User.find_by_email_address password_reset_request_params[:email_address]

    if user
      user.reset_token = SecureRandom.urlsafe_base64(10)
      user.save(validate: false)

      UserMailer.password_reset_request(user).deliver

      render :email_sent
    else
      flash[:error] = "That's not the email address you are looking for"
      render :new
    end
  end

  private

  def password_reset_request_params
    params.require(:password_reset_request).permit(:email_address)
  end

end
