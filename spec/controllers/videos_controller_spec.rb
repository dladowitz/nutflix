require "spec_helper"

describe VideosController do
  subject { get :index }
  let(:comedy)  { Category.create(name: "Comedy") }
  let(:scifi)  { Category.create(name: "Sci-Fi") }
  let(:iron_man){ Video.create title: "Iron Man", description: "Someone Saves the world",  categroy_id: 1}
  let(:thor)    { Video.create title: "Thor",     description: "Someone Saves the world",  categroy_id: 2}

  before { subject }

  describe "GET 'index'" do
    it "renders the index template" do
      expect(response).to render_template :index
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "returns an array of categories" do
      expect(assigns(:categories)).to match_array [comedy, scifi ]
    end
  end

  describe "GET 'show'" do
    before :each do
      @video = Video.create title: "Iron Man", description: "Someone Saves the world"
      get :show, {id: 1}
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
end
