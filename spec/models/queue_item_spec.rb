require "spec_helper"

describe QueueItem do
  let(:queue_item) { queue_items(:james_bonds_first_qi) }

  it { should validate_numericality_of(:queue_rank).only_integer }
  it { should validate_presence_of :queue_rank }
  it { should belong_to :user  }
  it { should validate_presence_of :user }
  it { should belong_to :video }
  it { should validate_presence_of :video }

  it "should have a valid factory" do
    expect(create(:queue_item, queue_rank: 10)).to be_instance_of QueueItem
  end

  it "should have a unique queue_rank across all queue items belonging to the same user" do
    bad_queue_item = QueueItem.new queue_rank: queue_item.queue_rank, user: queue_item.user, video: queue_item.video

    expect(bad_queue_item.save).to be false
  end

  it "should have a unique video_id across all queue items belonging to the same user" do
    bad_queue_item = QueueItem.new queue_rank: 10, user: queue_item.user, video: queue_item.video

    expect(bad_queue_item.save).to be false
  end

  describe "#category" do
    let(:category) { queue_item.video.category }
    subject { queue_item.category }

    context "when the video has a category" do
      it { should eq category }
    end

    context "when the video has no category" do
      before { queue_item.video.update_attributes category_id: nil }
      after  { queue_item.video.update_attributes category: category }

      it { should eq nil }
    end
  end

  describe "#category_name" do
    let(:category) { queue_item.video.category }
    subject { queue_item.category_name }

    context "when the video has a category" do
      it { should eq "Action" }
    end

    context "when the video has no category" do
      before { queue_item.video.update_attributes category_id: nil }
      after  { queue_item.video.update_attributes category: category }
      it { should eq "none" }
    end

  end

  describe "#rating" do
    subject { queue_item.rating }
    let(:review){ Review.where(user: queue_item.user, video: queue_item.video).first}

    context "when the video has been reviewed by the user" do
      it { should eq review.rating }
    end

    context "when the video has not been reviewed by the user yet" do
      before { review.update_attributes user_id: 100 }
      after  { review.update_attributes user_id: queue_item.user.id }

      it { should eq "none" }
    end

  end

  describe "#title" do
    subject { queue_item.video_title}

    it { should eq "Iron Man" }
  end
end
