require "spec_helper"

describe Video do
  let(:iron_man) { videos(:iron_man) }

  it { should belong_to(:category) }
  it { should have_many(:reviews) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }


  it "saves itself to the database" do
    video = Video.create(title: "Planet of the Apes", description: "Apes in the future")
    expect(Video.find_by_title "Planet of the Apes").to eq video
  end

  it "has a valid factory" do
    video = create(:video)
    expect(video).to be_valid
  end

  describe "#search_by_title" do

    context "when no matching videos are in the DB" do
      it "returns an empty array" do
        videos = Video.search_by_title "Superman"
        expect(videos.count).to eq 0
      end
    end

    context "when one matching video is in the DB" do
      it "returns an array with a single video" do
        videos = Video.search_by_title "Star Trek"
        expect(videos.count).to eq 1
      end
    end

    context "when two matching vidoes are in the DB" do
      before { @videos = Video.search_by_title "Thor" }
      it "returns an array with multiple vidoes ordered by created_at" do
        expect(@videos.count).to eq 2
      end

      it "does not return unmatched videos" do
        expect(@videos).to_not include videos(:iron_man)
      end
    end
  end

  describe "#average_rating" do
    context "there are reviews of the video in the db" do
      it "returns a number between 1 and 5" do
        expect(iron_man.average_rating).to be_between(1.0, 5.0)
      end

      it "should have a precision of one decimal point" do
        expect(iron_man.average_rating.to_s.length).to eq 3 #testing that the is only one number on either side of the decimal point
      end

      it "should correctly average the reveiw ratings" do
        average =  iron_man.reviews.pluck(:rating).sum / iron_man.reviews.count
        expect(iron_man.average_rating).to eq average
      end
    end

    context "there are no reviews of the video in the db" do
      it "should return 'no reviews' text" do
        expect(videos(:star_trek).average_rating).to eq "No Reviews Yet"
      end
    end
  end
end

