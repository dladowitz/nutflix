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
        videos = Video.search_by_title "Thor"
        expect(videos.count).to eq 1
      end
    end

    context "when two matching vidoes are in the DB" do
      before { @videos = Video.search_by_title "Iron" }
      it "returns an array with multiple vidoes ordered by created_at" do
        expect(@videos.count).to eq 2
      end

      it "does not return unmatched videos" do
        expect(@videos).to_not include videos(:thor)
      end
    end
  end
end

