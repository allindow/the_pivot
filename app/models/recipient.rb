class Creature < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true

  belongs_to :type  
  has_many :creatures_fundings
  has_many :fundings, through: :creatures_fundings
  # validates :type, presence: true
  def retire
    update_attribute(:retired, true)
  end
end
