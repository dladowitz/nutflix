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
end

