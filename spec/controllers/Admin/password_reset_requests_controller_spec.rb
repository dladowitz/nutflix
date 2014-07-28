require "spec_helper"

describe Admin::PasswordResetRequestsController do
  describe "GET #new" do
    subject { get :new }

    it "should render the page" do
      expect(subject).to render_template :new
    end
  end

  describe "POST #create" do
    subject { post :create, password_reset_request: {email_address: "james@007.com"} }
    before  { subject }
    after   { ActionMailer::Base.deliveries.clear }

    context "when the email is found in the database" do
      it "renders to the confirmation page" do
        expect(subject).to render_template :email_sent
      end

      describe "Sending the reset email" do
        it "sends an email" do
          expect(ActionMailer::Base.deliveries).to_not be_empty
        end

        it "sends to the correct email address" do
          email = ActionMailer::Base.deliveries.last
          expect(email.to).to eq ["james@007.com"]
        end

        skip "contains a reset link" do
          email = ActionMailer::Base.deliveries.last
          link = #### TODO how can we know the link ahead of time? Stubbing
          expet(email.body).to include(link)
        end
      end

    end

    context "when the email is not found in the database" do
      subject { post :create, password_reset_request: { email_address: "noone@none.com"} }

      it "does not send an email" do
        expect(ActionMailer::Base.deliveries).to be_empty
      end

      it "renders the new template" do
        subject
        expect(subject).to render_template :new
      end

      it "displays an error message" do
        subject
        expect(flash[:error]).to be_present
      end
    end
  end

end
