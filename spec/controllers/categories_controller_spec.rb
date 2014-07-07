require "spec_helper"

describe CategoriesController do
  describe "GET 'show'" do
    subject { get :show, id: cat1.id }

    let(:cat1)    {create(:category)}
    let(:cat2)    {create(:category)}

    let!(:video1) {create(:video, category: cat1)}
    let!(:video2) {create(:video, category: cat1)}
    let!(:video3) {create(:video, category: cat2)}

    before { subject }

    it "renders the show template" do
      expect(response).to render_template :show
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "finds the correct category" do
      expect(assigns(:category)).to eq cat1
    end

    it "shows all the videos in the choosen category" do
      expect(assigns(:videos)).to match_array [video1, video2]
    end

    it "does not show videos in another category" do
      expect(assigns(:videos)).to_not include video3
    end

  end
end
