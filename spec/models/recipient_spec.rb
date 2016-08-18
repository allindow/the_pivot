require 'rails_helper'

RSpec.describe Recipient, type: :model do
  # it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should have_db_column :amount_received }
  # it { should validate_presence_of :description }
  # it { should validate_presence_of :country }
  it { should belong_to :organization }
end
