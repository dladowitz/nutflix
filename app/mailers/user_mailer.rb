class UserMailer < ActionMailer::Base
  default from: "dladowitz@gmail.com"

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

  def invitation_email(invitation_options)
    inviter        = User.find invitation_options[:inviter_id]
    @token         = invitation_options[:token]
    @message       = invitation_options[:message]
    @name          = invitation_options[:friends_name]
    @email_address = invitation_options[:email_address]

    mail(to: @email_address, subject: "#{inviter.full_name} has an important message for you.")
  end

end
