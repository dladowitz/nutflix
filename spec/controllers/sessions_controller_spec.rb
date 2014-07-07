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

    let(:user1) {create(:user, password: "123456")}

    context "with a correct email and password" do
      subject { post :create, { email_address: user1.email_address, password: "123456"}  }

      it "finds the correct user in the database" do
        subject
        expect(assigns(:user).email_address).to eq user1.email_address
      end

      it "redirects to the vidoes_path" do
        expect(subject).to redirect_to videos_path
      end
    end

    context "with an incorrect password" do
      subject { post :create, email_address: user1.email_address, password: "bad_password" }
      it "renders the signin new page" do
        expect(subject).to render_template :new
      end
    end
  end
end
