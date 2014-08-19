require "spec_helper"

describe StripeWrapper::Customer, "#create" do
  let(:token)  { StripeWrapper::Token.create({ number: "4242424242424242", exp_month: 8, exp_year: 2015, cvc: "314" }).id }
  subject { StripeWrapper::Customer.create(token) }

  context "with a valid card" do
    it "returns a customer object with an id" do
      expect(subject.id).to be_an_instance_of String
    end

    it "returns :success in the status" do
      expect(subject.successful?).to be true
    end

    it "returns a message with a customer id" do
      expect(subject.status_message).to match "Customer created with id of"
    end
  end

  context "with an invalid card number" do
    let(:token)  { StripeWrapper::Token.create({ number: "4000000000000002", exp_month: 8, exp_year: 2015, cvc: "314" }).id }
    it "returns :failure in the status" do
      expect(subject.successful?).to be false
    end

    it "returns a message" do
      expect(subject.status_message).to eq "Your card was declined."
    end
  end

  context "with an expired card" do
    let(:token)  { StripeWrapper::Token.create({ number: "4242424242424242", exp_month: 8, exp_year: 2011, cvc: "314" }).id }
    subject { StripeWrapper::Customer.create(token) }

    it "returns :failure in the status" do
      expect(subject.successful?).to be false
    end

    it "returns a message" do
      expect(subject.status_message).to match "Your card's expiration year is invalid"
    end
  end
end

describe StripeWrapper, "#set_api_key" do
  it "returns the secret key" do
    expect(StripeWrapper.set_api_key).to eq ENV["STRIPE_SECRET_KEY"]
  end
end

describe StripeWrapper::Charge, "#create" do
  let(:amount) { 100 }
  let(:token)  { Stripe::Token.create(:card => { number: "4242424242424242", exp_month: 8, exp_year: 2015, cvc: "314" }).id }
  subject { StripeWrapper::Charge.create(token, amount) }

  context "with a valid card" do
    it "should return :success in the status" do
      expect(subject.successful?).to be true
    end

  it "returns a message" do
      expect(subject.status_message).to eq "Card charged 100 cents"
    end
  end

  context "with an invalid card number" do
    let(:token)  { Stripe::Token.create(:card => { number: "4000000000000002", exp_month: 8, exp_year: 2015, cvc: "314" } ).id }
    it "should return :failure in it's status" do
      expect(subject.successful?).to be false
    end

    it "returns a message" do
      expect(subject.status_message).to eq "Your card was declined."
    end
  end

  context "with an invalid expiration date" do
    let(:token)  { Stripe::Token.create(card: { number: "4242424242424242", exp_month: 8, exp_year: 2010, cvc: "314" }).id }
    skip "should return :failure in it's status" do
      expect(subject.successful?).to be false
    end

    skip "returns a message" do
      expect(subject.status_message).to eq "Your card was declined."
    end
  end

  context "with a valid customer" do
    it "is successful"
    it "has a status_message"
  end

  context "with an invalid customer" do
    it "is not successful"
    it "has a status_message"
  end
end

describe StripeWrapper::Token, "#create" do
  subject { StripeWrapper::Token.create(options)}

  context "with a valid card" do
    let(:options) { { number: "4242424242424242", exp_month: 8, exp_year: 2015, cvc: "314" } }

    it "returns a token object with an id" do
      expect(subject.id).to be_an_instance_of String
    end

    it "is successful" do
      expect(subject.successful?).to be true
    end

    it "has a message" do
      expect(subject.status_message).to match "Token is "
    end

  end

  context "with an invalid card number" do
    let(:options) { { number: "4000000000000002", exp_month: 8, exp_year: 2015, cvc: "314" } }

    it "is not successful" do
      expect(subject.successful?).to be true
    end

    it "has a message" do
      expect(subject.status_message).to match "Token is "
    end
  end

  context "with an invalid expiration date" do
    let(:options) { { number: "4242424242424242", exp_month: 8, exp_year: 2010, cvc: "314" } }

    it "is not successful" do
      expect(subject.successful?).to be false
    end

    it "has a message" do
      expect(subject.status_message).to eq "Your card's expiration year is invalid."
    end
  end
end
