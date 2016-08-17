class Creature < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true

  belongs_to :organization
  # validates :organization, presence: true
  has_many :recipient_fundings
  has_many :fundings, through: :recipient_fundings

  def retire
    update_attribute(:retired, true)
  end
end
