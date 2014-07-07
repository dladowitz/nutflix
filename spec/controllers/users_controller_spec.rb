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
      expect(assigns(:user)).to be_new_record
      expect(assigns(:user)).to be_kind_of(User)
    end
  end

  describe "POST 'create'" do
    context "with valid input for all fields" do
      subject { post :create, user: {email_address: "tony@stark_labs.com", password: "the_mandarin", full_name: "Tony Stark" } }
      before { subject }

      it "returns http 302 redirect" do
        expect(response.status).to eq 302
      end

      it "redirects to the signin page" do
        expect(response).to redirect_to signin_path
      end

      it "creates a user in the database" do
        expect(assigns(:user)).to eq User.find_by_email_address("tony@stark_labs.com")
      end
    end

    context "with invalid inputs" do
      subject { post :create, user: { email_address: nil, password: nil, full_name: nil } }
      before { subject }

      it "renders the new template" do
        expect(response).to render_template :new
      end

      it "should not create a record in the database" do
        expect(User.count).to eq 0
      end
    end
  end
end