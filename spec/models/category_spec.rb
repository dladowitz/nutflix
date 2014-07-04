require "spec_helper"

describe Category do
  let(:category){ create(:category) }

  it { should have_many(:videos) }
  it { should validate_presence_of(:name) }

  it "saves itself to the database" do
    category = Category.create(name: "true crime")
    expect(Category.find_by_name "true crime").to eq category
  end

  it "has a valid factory" do
    expect(category).to be_valid
  end

  context "when another catagory of the same name exists" do
    before { Category.create name: "Comedy" }
    it "should not be valid" do
      expect(Category.create name: "Comedy").to_not be_valid
    end
  end

  describe "#recent_videos" do
    before :each do
      @category = create(:category, name: "Romance")
      @video1   = create(:video, category: @category, created_at: 6.days.ago)
      @video2   = create(:video, category: @category, created_at: 5.days.ago)
      @video3   = create(:video, category: @category, created_at: 4.days.ago)
      @video4   = create(:video, category: @category, created_at: 3.days.ago)
      @video5   = create(:video, category: @category, created_at: 2.days.ago)
      @video6   = create(:video, category: @category, created_at: 1.days.ago)
      @video7   = create(:video, category: @category, created_at: Time.now)
    end

    subject{ @category.recent_videos }

    context "when there are more than 6 videos in the category" do
      it "returns only 6 videos" do
        expect(subject.count).to eq 6
      end

      it "returns videos in reverse chronologic order" do
        expect(subject).to eq [@video7, @video6, @video5, @video4, @video3, @video2]
      end
    end

    context "when there are less than 6 vidoes in the category" do
      before { 3.times { @category.videos.first.delete} }

      it "returns all the vidoes in the category" do
        expect(subject.count).to eq 4
      end

      context "when there are no videos in the category" do
        before { @category.videos.each {|video| video.delete} }

        it "returns an empty array" do
          expect(subject.count).to be 0
        end
      end
    end
  end
end
