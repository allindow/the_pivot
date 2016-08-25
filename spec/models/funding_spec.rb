require 'rails_helper'

RSpec.describe Funding, type: :model do
  it { should have_many :recipient_fundings }
  it { should have_many :recipients }
  it { should belong_to :user }

  it "has a default status of completed" do
    funding = Funding.new
    expect(funding.status).to eq("awaiting payment")
  end

  it "has a status of paid" do
    funding = Funding.new(status: "paid")
    expect(funding.status).to eq("paid")
  end
end
