class Recipient < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  belongs_to :organization
  belongs_to :country
  # validates :organization, presence: true
  has_many :recipient_fundings
  has_many :fundings, through: :recipient_fundings

  def retire
    update_attribute(:retired, true)
  end
end
