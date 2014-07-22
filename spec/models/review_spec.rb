require "spec_helper"

describe Review do
  let(:user)  { users(:james_bond) }
  let(:video) { videos(:iron_man) }
  subject(:review) { reviews(:iron_man_review_1) }

  it { should belong_to(:video) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:rating) }

  it "should save itself to the database" do
    new_review = Review.create(user: user, video: video, rating: 4, text: "Thumbs Up!")

    expect(Review.find(new_review.id)).to be_instance_of Review
  end

  it "should have a valid factroy" do
    review = create(:review)
    expect(review).to be_instance_of Review
  end
end
