class Creature < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true

  belongs_to :organization
  # validates :organization, presence: true
  has_many :recipient_fundings
  has_many :orders, through: :recipient_fundings
  # validates :type, presence: true
  def retire
    update_attribute(:retired, true)
  end
end
