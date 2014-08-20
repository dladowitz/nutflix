# Use with binding.pry
# require 'sidekiq'
# require 'sidekiq/testing/inline'

class StripeCustomerCreationWorker
  include Sidekiq::Worker

  def perform(token, user_id)
    Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
    user = User.find user_id

    unless Rails.env.test?
      customer = StripeWrapper::Customer.create(
        :card => token,
      )
    else
      customer = create_test_customer
    end

    user.update_column(:stripe_customer_id, customer.id)

    ChargeWorker.perform_async(user_id, 2000)
  end


  private
  # Rails forces creation of structs outside of methods
  Customer = Struct.new(:id)

  def create_test_customer
    customer = Customer.new("abc123")
    return customer
  end
end
