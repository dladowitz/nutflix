require "spec_helper"

describe Category do
  let(:category){ create(:category) }

  it "has a valid factory" do
    expect(category).to be_valid
  end

  context "when created with a name" do
    it "should be valid" do
      expect(Category.create name: "Comedy").to be_valid
    end

    it "should set the name field properly" do
      expect(category.name).to eq "Comedy"
    end
  end

  context "without a neame given" do
    it "should not be valid" do
      expect(Category.create).to_not be_valid
    end
  end

  context "when another catagory of the same name exists" do
    before { Category.create name: "Comedy" }
    it "should not be valid" do
      expect(Category.create name: "Comedy").to_not be_valid
    end
  end
end
