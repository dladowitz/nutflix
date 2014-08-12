module StripeWrapper
  def self.set_api_key
    Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
  end

  class Customer

    # customer = Stripe::Customer.create(
    #   :card => token,
    # )
  end

  class Token
    def initialize(response, status)
      @status = status
      @response = response
    end

    def self.create(options)
      StripeWrapper.set_api_key

      begin
        response = Stripe::Token.create(card: options)
        new(response, :success)
      rescue Stripe::CardError => error
        new(error, :failure)
      end
    end

    def successful?
      true
    end
  end

  class Charge
    attr_reader :response, :status

    def initialize(response, status)
      @response = response
      @status =  status
    end

    def self.create(token, amount)
      StripeWrapper::set_api_key
      begin
        response = Stripe::Charge.create(:amount => amount, :currency => "usd", :card => token)
        new(response, :success)
      rescue Stripe::CardError => error
        new(error, :failure)
      end

    end

    def successful?
      status == :success
    end

    def status_message
      if response.try(:amount)
        "Card charged #{response.amount} cents"
      else
        response.message
      end
    end
  end
end
