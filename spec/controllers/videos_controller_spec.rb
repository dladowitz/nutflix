require "spec_helper"

describe VideosController do
  describe "GET 'index'" do
    let!(:comedy)     { create(:category_comedy) }
    let!(:action)     { create(:category_action) }
    subject { get :index }

    context "with an authenticated user" do
      before :each do
        session[:user_id] = (create(:user)).id
        subject
      end

      it "renders the index template" do
        expect(response).to render_template :index
      end

      it "returns http success" do
        expect(response).to be_success
      end

      it "returns an array of categories" do
        expect(assigns(:categories)).to match_array [comedy, action]
      end
    end

    context "with an unauthenticated user" do
      it "renders the signin page" do
        subject
        expect(response).to redirect_to signin_path
      end
    end
  end

  describe "GET 'show'" do
    let!(:video) { create(:video) }
    subject { get :show, { id: video.id } }

    context "with an authenticated user" do
      before :each do
        session[:user_id] = (create(:user)).id
        subject
      end

      it "renders the show template" do
        expect(response).to render_template :show
      end

      it "returns success" do
        expect(response).to be_success
      end

      it "returns the correct video" do
        expect(assigns(:video).title).to match video.title
      end
    end

    context "with an unathenticated user" do
      it "redirects to the signin page" do
        subject
        expect(response).to redirect_to signin_path
      end
    end
  end

  describe "POST 'search'" do
    subject { post :search, { search_term: "Iron"} }

    context "with an authenticated user" do
      before :each do
        session[:user_id] = (create(:user)).id
        subject
      end

      it "renders the search template" do
        expect(response).to render_template :search
      end

      it "returns a success" do
        expect(response).to be_success
      end

      it "returns an array of the correct videos" do
        iron_man   = create(:video, title: "Iron Man")
        iron_man_2 = create(:video, title: "Iron Man 2")
        thor       = create(:video, title: "Thor")

        expect(assigns(:videos)).to match_array [iron_man, iron_man_2]
      end
    end

    context "with an unathenticated user" do
      it "redirects to the signin page" do
        subject
        expect(response).to redirect_to signin_path
      end
    end
  end
end
