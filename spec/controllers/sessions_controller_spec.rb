require "spec_helper"

describe SessionsController do
  describe "GET 'new'" do
    subject { get :new }
    before  { subject }

    context "for unathenticated users" do
      it "renders the new template" do
        expect(response).to render_template :new
      end

      it "returns http success" do
        expect(response).to be_success
      end
    end

    context "for authenticated users" do
      it "redirects to the vidoes path" do
        user1 = create(:user)
        session[:user_id] = user1.id
        expect(response).to redirect_to videos_path
      end
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

      it "sets the flash" do
        subject
        expect(flash[:success]).to eq "Successfully logged in"
      end

      it "redirects to the vidoes_path" do
        expect(subject).to redirect_to videos_path
      end
    end

    context "with an incorrect password" do
      subject { post :create, email_address: user1.email_address, password: "bad_password" }

      it "finds the correct user in the database" do
        subject
        expect(assigns(:user).email_address).to eq user1.email_address
      end
      it "renders the signin new page" do
        expect(subject).to render_template :new
      end

      it "sets the flash" do
        subject
        expect(flash[:danger]).to eq "Password is incorrect"
      end
    end

    context "with an incorrect email address" do
      subject { post :create, email_address: "not in database"}
      before { subject }

      it "does not find a user in the database" do
        expect(assigns(:user)).to be nil
      end

      it "renders the signin new page" do
        expect(response).to render_template :new
      end

      it "sets the flash" do
        expect(flash[:danger]).to eq "Email is incorrect"
      end
    end
  end
end
