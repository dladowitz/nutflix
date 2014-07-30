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
    @reset_token = user.reset_token

    mail(to: @user.email_address, subject: "Password Reset")
  end

  def invitation_email(user_hash)
    @referrer       = User.find user_hash[:referrer_id]
    @referral_token = @referrer.referral_token
    @message        = user_hash[:message]
    @name           = user_hash[:friends_name]
    @email_address  = user_hash[:email_address]

    mail(to: user_hash[:email_address], subject: "#{@referrer.full_name} has an important message for you.")
  end

end
