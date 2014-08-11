class ChargeWorker
  include Sidekiq::Worker

  def perform(user_id, amount)

    Stripe.api_key = ENV["STRIPE_SECRET_KEY"]

    customer_id = User.find(user_id).stripe_customer_id

    unless Rails.env.test?
      charge = Stripe::Charge.create(
        :amount => amount,
        :currency => "usd",
        :customer => customer_id,
      )
    else
      charge = create_test_charge
    end


    if charge
      Charge.create(user_id: user_id, amount: charge.amount, fee: charge.fee, refunded: charge.refunded, paid: charge.paid)
    end
  end


  private
  # Rails forces creation of structs outside of methods
  StripeCharge = Struct.new(:amount, :fee, :refunded, :paid )

  def create_test_charge
    charge = StripeCharge.new(2000, 88, false, true)
    return charge
  end
end
