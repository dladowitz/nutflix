class InvitationsController < ApplicationController

  def create

    invitation = current_user.invitations.create
    invitation_options = { inviter_id:    current_user.id,
                           token:         invitation.token,
                           email_address: invitation_params[:email_address],
                           friends_name:  invitation_params[:friends_name],
                           message:       invitation_params[:message] }

    UserMailer.invitation_email(invitation_options).deliver
    render "invitation_sent"
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email_address, :friends_name, :message)
  end
end
