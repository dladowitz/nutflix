class InvitationsController < ApplicationController

  def create
    params = invitation_params.merge( inviter_id: current_user.id )
    invitation = current_user.invitations.create(params)

    # alternate version - UserMailer.delay.invitation_email(invitation_options)
    InvitationsWorker.perform_async(invitation.id)

    render "invitation_sent"
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email_address, :name, :message)
  end
end
