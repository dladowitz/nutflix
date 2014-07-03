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
end
