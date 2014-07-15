require "spec_helper"

describe QueueItem do
  let(:user) { users(:james_bond) }
  let(:video) { videos(:iron_man) }

  it { should validate_presence_of :queue_rank }
  it { should belong_to :user  }
  it { should validate_presence_of :user }
  it { should belong_to :video }
  it { should validate_presence_of :video }


  it "should have a valid factory" do
    expect(create(:queue_item, queue_rank: 10)).to be_instance_of QueueItem
  end

  it "should have a unique queue_rank across all queue items belonging to the same user" do
    queue_item     = queue_items(:james_bond_first_qi)
    bad_queue_item = QueueItem.new queue_rank: queue_item.queue_rank, user: queue_item.user, video: video

    expect(bad_queue_item.save).to be false
  end

  it "should have a unique video_id across all queue items belonging to the same user" do
    queue_item     = queue_items(:james_bond_first_qi)
    bad_queue_item = QueueItem.new queue_rank: 10, user: queue_item.user, video: queue_item.video

    expect(bad_queue_item.save).to be false
  end


end
