class PasswordResetRequestWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    UserMailer.password_reset_request(user).deliver
  end
end
