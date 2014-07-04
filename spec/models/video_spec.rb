require 'spec_helper'

describe Video do
  let(:video){ create(:video) }

  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }


  it "saves itself to the database" do
    video = Video.create(title: "Planet of the Apes", description: "Get your damn dirty hands off me")
    expect(Video.find_by_title "Planet of the Apes").to eq video
  end

  it "has a valid factory" do
    expect(video).to be_valid
  end

  describe "#search_by_title" do
    subject { Video.search_by_title "Iron" }

    context "when no matching videos are in the DB" do
      it "returns an empty array" do
        expect(subject).to match_array []
      end
    end

    context "when one matching video is in the DB" do
      it "returns an array with a single video" do
        iron_man = Video.create(title: "Iron Man", description: "The Beginning")

        expect(subject).to match_array [iron_man]
      end
    end

    context "when two matching vidoes are in the DB" do
      before :each do
        @iron_man   = Video.create(title: "Iron Man", description: "The Beginning")
        @iron_man_2 = Video.create(title: "Iron Man 2", description: "The Middle")
        @thor = Video.create(title: "Thor", description: "The Beginning")
      end

      it "returns an array with multiple vidoes ordered by created_at" do
        expect(subject).to eq [@iron_man_2, @iron_man]
      end

      it "does not return unmatched videos" do
        expect(subject).to_not include @thor
      end
    end
  end

  describe "#recent_videos" do
    context "when there are 7 vidoes in the db" do
      before :each do
        @videos = []
        7.times do
          video = create(:video)
          @videos << video
          # TODO speed this up!!
          sleep 1
        end
      end

      subject { Video.recent_videos }
      it "should return 6 videoes" do
        expect(subject.count).to eq 6
      end

      it "should order them from latest to earliest" do
        @videos.reverse!.pop
        expect(subject).to match_array(@videos)
      end
    end
  end
end

