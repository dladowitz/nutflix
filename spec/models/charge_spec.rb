require "spec_helper"

describe Charge do
  it { should belong_to :user }
  it { should validate_presence_of :user }
  it { should validate_presence_of :amount }
  it { should validate_numericality_of :amount }
  it { should validate_presence_of :fee }
  it { should validate_numericality_of :fee }

  it "has a valid factory" do
    expect( create(:charge) ).to be_valid
  end
end
