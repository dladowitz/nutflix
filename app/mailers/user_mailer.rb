class UserMailer < ActionMailer::Base
  default from: "dladowitz@gmail.com"

  def welcome_email(user)
    @user = user
    @url = "https://screen.yahoo.com/netflix-apology-000000795.html"

    mail(to: @user.email_address, subject: "Welcome to NutFlix")
  end

  def password_reset_request(user)
    @user = user
    @first_name = user.full_name.split(" ").first
    @reset_token = user.reset_token

    mail(to: @user.email_address, subject: "Password Reset")
  end

end
