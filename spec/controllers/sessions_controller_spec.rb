require "spec_helper"

describe SessionsController do

  describe "GET 'new'" do
    subject { get :new }
    before  { subject }

    it "renders the new template" do
      expect(response).to render_template :new
    end

    it "returns http success" do
      expect(response).to be_success
    end
  end

  describe "POST 'create'" do
    before  :each do
      User.create email_address: "bruce@banner.com", password: "smash", full_name: "Bruce Banner"
    end

    context "with a correct email and password" do
      subject { post :create, email_address: "bruce@banner.com", password: "smash"  }

      it "redirects to the vidoes_path" do

        expect(subject).to redirect_to videos_path
      end
    end

    context "with an incorrect password" do
      subject { post :create, email_address: "bruce@banner.com", password: "gamma ray" }
      it "renders the signin new page" do
        expect(subject).to render_template :new
      end
    end
  end
end
