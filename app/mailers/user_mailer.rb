class UserMailer < ActionMailer::Base
  default from: "\"The Underpants Gnomes\" <gnomes@underpantsgnomes.com>"

  def welcome_email(user)
    @user = user
    @url = "https://screen.yahoo.com/netflix-apology-000000795.html"

    mail(to: @user.email_address, subject: "Welcome to NutFlix")
  end

  def password_reset_request(user)
    @user = user
    @first_name = user.first_name
    @reset_token = user.token

    mail(to: @user.email_address, subject: "Password Reset")
  end

  def invitation_email(invitation)
    inviter        = User.find invitation.inviter_id
    @token         = invitation.token
    @message       = invitation.message
    @name          = invitation.name
    @email_address = invitation.email_address

    mail(to: @email_address, subject: "#{inviter.full_name} has an important message for you.")
  end

end
