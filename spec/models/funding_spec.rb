require 'rails_helper'

RSpec.describe Funding, type: :model do
  it { should have_many :recipient_fundings }
  it { should have_many :recipients }
  it { should belong_to :user }
end
