require "spec_helper"

describe ReviewsController do
  let(:user)  { create(:user) }
  let(:video) { create(:video) }

  describe "POST 'create'" do
    let(:params) { {user_id: user.id, video_id: video.id, rating: 2, text: "Thumbs Down!"} }
    subject { post :create, review: params }

    it "should redirect to the video page" do
      subject
      expect(response).to redirect_to video_path(video)
    end

    it "should create a review in the db" do
      expect{ subject }.to change{ Review.count }.by 1
    end
  end
end
