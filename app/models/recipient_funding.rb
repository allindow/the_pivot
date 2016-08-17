class RecipientFundings < ActiveRecord::Base
  belongs_to :recipient
  belongs_to :funding
end
