module StripeWrapper
  def self.set_api_key
    Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
  end

  class Customer
    attr_reader :response, :status

    def initialize(response, status)
      @status = status
      @response = response
    end

    def self.create(token)
      StripeWrapper.set_api_key

      begin
        response = Stripe::Customer.create(:card => token)
        new(response, :success)
      rescue Stripe::CardError, Stripe::InvalidRequestError => error
        new(error, :failure)
      end
    end

    def id
      response.id
    end

    def successful?
      status == :success
    end

    def status_message
      if response.try(:id)
        "Customer created with id of #{response.id}"
      else
        response.message
      end
    end
  end

  class Token
    attr_reader :response, :status

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
      status == :success
    end

    def id
      if successful?
        response.id
      else
        status_message
      end
    end

    def status_message
      if response.try(:id)
        "Token is #{response.id}"
      else
        response.message
      end

    end
  end

  class Charge
    attr_reader :response, :status

    def initialize(response, status)
      @response = response
      @status =  status
    end

    def self.create(options)
      StripeWrapper::set_api_key
      begin
        response = Stripe::Charge.create(amount: options[:amount],
                                         currency: "usd",
                                         card: options[:token],
                                         customer: options[:customer_id])

        new(response, :success)
      rescue Stripe::CardError, Stripe::InvalidRequestError => error
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
