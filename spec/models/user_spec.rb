require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :password }
  it { should validate_presence_of :username }
  it { should validate_uniqueness_of :username }
  it { should have_many :fundings }
  it { should have_secure_password }
  it { should have_db_column :role }
  it { should belong_to :organization }

  it "should validate the format of an email address" do
    user1 = User.new(username: "angela", password: "password")
    user2 = User.new(username: "angela@example.com", password: "password")
    expect(user1).to_not be_valid
    expect(user2).to be_valid
  end
end
