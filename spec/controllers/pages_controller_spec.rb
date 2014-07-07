require "spec_helper"

describe PagesController do
  describe "GET 'home'" do
    context "with an authenticated user" do
      it "should redirect to the videos path" do
        user = create(:user)
        session[:user_id] = user.id

        get :home
        expect(response).to redirect_to videos_path
      end
    end

    context "with an unauthenticated user" do
      it "should render the sign in page" do
        get :home
        expect(response).to render_template :home
      end
    end
  end
end
