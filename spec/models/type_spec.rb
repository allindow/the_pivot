require "rails_helper"

RSpec.describe Type, type: :model do
  it "has a valid factory" do
    FactoryGirl.create(:type).should be_valid
  end

  it "is invalid without a name" do
    FactoryGirl.build(:type, name: nil).should_not be_valid
  end
end
