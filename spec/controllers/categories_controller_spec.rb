require "spec_helper"

describe CategoriesController do
  describe "GET 'show'" do
    subject { get :show, id: 1 }
    before  do
      cat1 = create(:category)
      cat2 = create(:category, name: "Action")
      @video1 = create(:video, category: cat1)
      @video2 = create(:video, category: cat1)
      @video3 = create(:video, category: cat2)
      subject
    end

    it "renders the show template" do
      expect(response).to render_template :show
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "shows all the videos in the choosen category" do
      expect(assigns(:videos)).to match_array [@video1, @video2]
    end

    it "does not show videos in another category" do
      expect(assigns(:videos)).to_not include @video3
    end
  end
end
