class InvitationsWorker
  include Sidekiq::Worker

  def perform(invitation_id)
    invitation = Invitation.find invitation_id
    UserMailer.invitation_email(invitation).deliver
  end
end




