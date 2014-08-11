require "spec_helper"

describe CategoriesController do
  describe "GET 'show'" do
    subject { get :show, id: action.id }

    let!(:action)     { categories(:action) }
    let!(:iron_man)   { videos(:iron_man) }
    let!(:iron_man_2) { videos(:iron_man_2) }
    let!(:star_trek)  { videos(:star_trek) }

    before { subject }

    it "renders the show template" do
      expect(response).to render_template :show
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "finds the correct category" do
      expect(assigns(:category)).to eq action
    end

    it "shows all the videos in the choosen category" do
      expect(assigns(:videos)).to match_array action.videos
    end

    it "does not show videos in another category" do
      expect(assigns(:videos)).to_not include star_trek
    end
  end
end
