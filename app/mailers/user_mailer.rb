class UserMailer < ActionMailer::Base
  default from: "dladowitz@gmail.com"

  def welcome_email(user)
    @user = user
    @url = "https://screen.yahoo.com/netflix-apology-000000795.html"

    mail(to: @user.email_address, subject: "Welcome to NutFlix")
  end

end
