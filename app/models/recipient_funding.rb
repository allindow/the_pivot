class RecipientsOrder < ActiveRecord::Base
  belongs_to :recipient
  belongs_to :order
end