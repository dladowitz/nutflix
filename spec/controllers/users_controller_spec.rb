require "spec_helper"

describe UsersController do
  describe "GET 'new'" do
    subject{ get :new }

    before { subject }
    it "renders the new page" do
      expect(response).to render_template :new
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "creates a new user" do
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe "POST 'create'" do
    context "for a paid account" do
      context "with valid input for all fields" do
        subject { post :create, stripeToken: "fake_token", user: { email_address: "tony@stark.com", password: "mandarin", full_name: "Tony Stark"} }

        let!(:success_response) { double("stripe response", successful?: true, status_message: "Card charged 100 cents" ) }
        before { StripeWrapper::Charge.stub(:create).and_return(success_response) }

        before { ActionMailer::Base.deliveries.clear }

        it "creates a user" do
          expect { subject }.to change{User.count}.by 1
        end

        it "redirects to the sign-in page" do
          expect(subject).to redirect_to signin_path
        end

        it "sends a welcome email" do
          subject
          expect(ActionMailer::Base.deliveries).to_not be_empty
        end

        it "sends to the correct user" do
          subject
          email = ActionMailer::Base.deliveries.last
          expect(email.to).to eq ["tony@stark.com"]
        end

        it "has the correct content in the body" do
          subject
          email = ActionMailer::Base.deliveries.last
          expect(email.body).to include("Welcome Tony Stark")
        end

        it "calls StripeWrapper::Charge" do
          StripeWrapper::Charge.should_receive(:create).with(token: "fake_token", amount: 2000)
          subject
        end
      end

      context "with invalid card number" do
        subject { post :create, stripeToken: "fake_token", user: { email_address: "tony@stark.com", password: "mandarin", full_name: "Tony Stark"} }

        let!(:failure_response) { double("stripe response", successful?: false, status_message: "Your card was declined." ) }
        before { StripeWrapper::Charge.stub(:create).and_return(failure_response) }
        before  { ActionMailer::Base.deliveries.clear }

        it "does NOT create a new user in the db" do
          expect { subject }.not_to change{User.count}
        end

        it "renders the new template" do
          expect(subject).to render_template :new
        end

        it "calls StripeWrapper::Charge" do
          StripeWrapper::Charge.should_receive(:create).with(token: "fake_token", amount: 2000)
          subject
        end

        it "does NOT send a welcome email" do
          subject
          expect(ActionMailer::Base.deliveries).to be_empty
        end
      end

      context "with expired card" do
        #### Pretty sure you can't submit an expired card via stripe's JS library. Meaning it'll never post to the rails server.
      end

      context "with invalid user info" do
        let!(:success_response) { double("stripe response", successful?: true, status_message: "Card charged 100 cents" ) }
        before { StripeWrapper::Charge.stub(:create).and_return(success_response) }

        before { ActionMailer::Base.deliveries.clear }

        context "with missing email" do
          subject { post :create, stripeToken: "fake_token", user: { email_address: nil, password: "mandarin", full_name: "Tony Stark"} }

          it "does NOT create a user" do
            expect { subject }.to_not change{User.count}
          end

          it "does Not call StripeWrapper:Charge" do
            StripeWrapper::Charge.should_not_receive(:create)
            subject
          end

          it "does NOT send a welcome email" do
            subject
            expect(ActionMailer::Base.deliveries).to be_empty
          end

          it "sets the flash error message" do
            subject
            expect(flash[:danger]).to eq "Missing Personal Info"
          end
        end

        context "with missing password" do
          subject { post :create, stripeToken: "fake_token", user: { email_address: "tony@stark.com", password: nil, full_name: "Tony Stark"} }

          it "does NOT create a user" do
            expect { subject }.to_not change{User.count}
          end

          it "does Not call StripeWrapper:Charge" do
            StripeWrapper::Charge.should_not_receive(:create)
            subject
          end

          it "does NOT send a welcome email" do
            subject
            expect(ActionMailer::Base.deliveries).to be_empty
          end
        end

        context "with missing full name" do
          subject { post :create, stripeToken: "fake_token", user: { email_address: "tony@stark.com", password: "mandarin", full_name: nil} }

          it "does NOT create a user" do
            expect { subject }.to_not change{User.count}
          end

          it "does Not call StripeWrapper:Charge" do
            StripeWrapper::Charge.should_not_receive(:create)
            subject
          end

          it "does NOT send a welcome email" do
            subject
            expect(ActionMailer::Base.deliveries).to be_empty
          end
        end
      end
    end

    context "for a free account" do
      context "with invalid inputs" do
        subject { post :create, user: { email_address: nil, password: nil, full_name: nil } }
        before   { ActionMailer::Base.deliveries.clear }

        it "renders the new template" do
          expect(subject).to render_template :new
        end

        it "sets @user" do
          subject
          expect(assigns(:user)).to be_instance_of(User)
        end

        it "does not create a record in the database" do
          expect { subject }.to_not change{User.count}
        end

        it "does not sent out an email" do
          subject
          expect(ActionMailer::Base.deliveries).to be_empty
        end
      end
    end
  end

  describe "GET 'show'" do
    let(:user_1) { users(:dr_evil) }
    let(:user_2) { users(:james_bond) }
    subject { get :show, id: user_2.id }

    it_behaves_like "requires signin without an authenticated user" do
      let(:http_request)        { subject }
    end

    context "with an authenticated user" do
      before do
        login_user user_1
        subject
      end

      it_behaves_like "renders template with an authenticated user" do
        let(:http_request)           { subject }
        let(:authenticated_template) { :show }
      end

      it "finds all the users reviews" do
        reviews = user_2.reviews
        expect(assigns(:reviews).count).to eq reviews.count
      end

      it "finds all the videos the users queue" do
        queue_items = user_2.queue_items
        expect(assigns(:queue_items).count).to eq queue_items.count
      end
    end
  end
end
