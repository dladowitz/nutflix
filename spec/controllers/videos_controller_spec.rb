require "spec_helper"

describe VideosController do
  subject { get :index }
  let(:iron_man){ Video.create title: "Iron Man", description: "Someone Saves the world" }
  let(:thor)    { Video.create title: "Thor",     description: "Someone Saves the world" }

  describe "GET 'index'" do
    it "renders the index template" do
      subject
      expect(response).to render_template :index
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      subject
      expect(response).to be_success
    end
  end

  describe "GET 'index'" do
    it "returns an array of videos" do
      subject
      expect(assigns(:videos)).to match_array [iron_man, thor]
    end
  end
end
