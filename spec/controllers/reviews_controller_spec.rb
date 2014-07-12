require "spec_helper"

describe ReviewsController do
  let(:james_bond) { users(:james_bond) }
  let(:iron_man)   { videos(:iron_man) }

  describe "POST 'create'" do
    let(:params) { {user_id: james_bond.id, video_id: iron_man.id, rating: 2, text: "Thumbs Down!"} }
    subject { post :create, review: params }

    it "should redirect to the video page" do
      subject
      expect(response).to redirect_to video_path(iron_man)
    end

    it "should create a review in the db" do
      expect{ subject }.to change{ Review.count }.by 1
    end
  end
end
