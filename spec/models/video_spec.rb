require 'spec_helper'

describe Video do
  let(:video){ create(:video) }

  it "has a valid factory" do
    expect(video).to be_valid
  end

  it "belongs to a category" do
    action = Category.create name: "Action"
    xmen = Video.create title: "Xmen", category: action
    expect(xmen.category).to eq (Category.find_by_name "Action")
  end

  context "when created with a name" do
    it "should be valid" do
      expect(Video.create title: "Super Troopers").to be_valid
    end
  end

  context "when created without a name" do
    it "should not be valid" do
      expect(Video.create).to_not be_valid
    end
  end
end

