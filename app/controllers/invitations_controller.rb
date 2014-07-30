class InvitationsController < ApplicationController

  def create
    user = User.find(current_user.id)
    user.referral_token = SecureRandom.urlsafe_base64(10)
    user.save(validate: false)
    user_hash = { referrer_id:   current_user.id,
                  email_address: invitation_params[:email_address],
                  friends_name:  invitation_params[:friends_name],
                  message:       invitation_params[:message] }

    UserMailer.invitation_email(user_hash).deliver
    render "invitation_sent"
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email_address, :friends_name, :message)
  end
end
