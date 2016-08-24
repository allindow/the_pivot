require 'rails_helper'

RSpec.describe Country, type: :model do
  it { should have_many :recipients }

  it "can generate slug" do
    country = Country.create(name: "Ghana")

    expect(country.slug).to eq("ghana")
  end
end
