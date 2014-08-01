class PasswordResetRequestsController < ApplicationController
  def create
    user = User.find_by_email_address password_reset_request_params[:email_address]

    if user
      PasswordResetRequestWorker.perform_async(user.id)
      # Could also use
      # UserMailer.delay.password_reset_request(user)

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
