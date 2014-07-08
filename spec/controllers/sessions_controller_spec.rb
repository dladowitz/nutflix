require "spec_helper"

describe SessionsController do
  describe "GET 'new'" do
    subject { get :new }
    before  { subject }

    context "for authenticated users" do
      it "redirects to the vidoes path" do

        session[:user_id] = (create(:user)).id
        expect(response).to render_template :new
      end
    end

    context "for unathenticated users" do
      it "renders the new template" do
        expect(response).to render_template :new
      end

      it "returns http success" do
        expect(response).to be_success
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

  describe "GET 'destroy'" do
    subject { get :destroy }

    context "with an authenticated user" do
      before do
        session[:user_id] = (create(:user).id)
        subject
      end

      it "should log the user out" do
        expect(session[:user_id]).to be nil
      end

      it "should redirect to the home page" do
        expect(response).to redirect_to home_path
      end
    end

    context "with an unauthenticated user" do
      it "should redirect to the home page" do
        subject
        expect(response).to redirect_to home_path
      end
    end
  end

  describe "DELETE 'destroy'" do
    it "should clear the session's user id" do
      session[:user_id] = (create(:user)).id
      delete :destroy
      expect(session[:user_id]).to be nil
    end
  end
end
