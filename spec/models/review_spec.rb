require "spec_helper"

describe Review do
  let(:user)  { create(:user) }
  let(:video) { create(:video) }
  subject(:review) { Review.create user: user, video: video }

  it { should belong_to(:video) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:rating) }

  it "should save itself to the database" do
    review = Review.create(user: user, video: video, rating: 4, text: "Thumbs Up!")
    expect(Review.find(review.id)).to be_instance_of Review
  end

  it "should have a valid factroy" do
    review = create(:review)
    expect(review).to be_instance_of Review
  end
end
