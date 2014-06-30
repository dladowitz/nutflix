require "spec_helper"

describe VideosController do
  subject { get :index }
  let(:iron_man){ Video.create title: "Iron Man", description: "Someone Saves the world" }
  let(:thor)    { Video.create title: "Thor",     description: "Someone Saves the world" }

  before { subject }

  describe "GET 'index'" do
    it "renders the index template" do
      expect(response).to render_template :index
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "returns an array of videos" do
      expect(assigns(:videos)).to match_array [iron_man, thor]
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
