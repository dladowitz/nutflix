require "spec_helper"

describe VideosController do
  subject { get :index }
  let!(:comedy)     { create(:category_comedy) }
  let!(:action)     { create(:category_action) }

  before { subject }

  describe "GET 'index'" do
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

  describe "GET 'show'" do
    before :each do
      @video = create(:video)
      get :show, { id: @video.id }
    end

    it "renders the show template" do
      expect(response).to render_template :show
    end

    it "returns success" do
      expect(response).to be_success
    end

    it "returns the correct video" do
      expect(assigns(:video).title).to match @video.title
    end
  end

  describe "POST 'search'" do
    subject { post :search, { search_term: "Iron"} }

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
end
