require 'rails_helper'

RSpec.describe Organization, type: :model do
  it { should have_many :recipients }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  # it { should have_db_column :status }
  # it { should validate_presence_of :description }
end
