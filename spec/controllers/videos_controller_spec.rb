require "spec_helper"

describe VideosController do
  fixtures :users

  describe "GET 'index'" do
    let!(:comedy) { categories(:comedy) }
    let!(:action) { categories(:action) }
    subject { get :index }

    context "with an authenticated user" do
      before :each do
        session[:user_id] = users(:james_bond).id
        subject
      end

      it "renders the index template" do
        expect(response).to render_template :index
      end

      it "returns http success" do
        expect(response).to be_success
      end

      it "returns an array of categories" do
        expect(assigns(:categories)).to match_array Category.all
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
    let!(:video)  { videos(:iron_man) }
    subject { get :show, { id: video.id } }

    context "with an authenticated user" do
      before :each do
        session[:user_id] = (users(:james_bond)).id
      end

      it "renders the show template" do
        subject
        expect(response).to render_template :show
      end

      it "returns success" do
        subject
        expect(response).to be_success
      end

      it "returns the correct video" do
        subject
        expect(assigns(:video).title).to match video.title
      end

      context "with reviews of the video in the db" do
        it "returns all the reviews of the video" do
          create(:review, video: video)
          subject

          expect(assigns(:reviews).count).to eq video.reviews.count
        end
      end

      context "with no reviews of the video in the db" do
        it "returns no reviews of the vidoe"
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
        session[:user_id] = users(:james_bond).id
        subject
      end

      it "renders the search template" do
        expect(response).to render_template :search
      end

      it "returns a success" do
        expect(response).to be_success
      end

      it "returns an array of the correct videos" do
        iron_man   = videos(:iron_man)
        iron_man_2 = videos(:iron_man_2)
        thor       = videos(:thor)

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
