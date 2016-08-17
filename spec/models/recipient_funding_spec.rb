require 'rails_helper'

RSpec.describe RecipientFunding, type: :model do
  it { should belong_to :recipient }
  it { should belong_to :funding }
  it { should have_db_column :microloan_amount }
end
