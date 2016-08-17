class Creature < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true

  belongs_to :organization  
  has_many :creatures_orders
  has_many :orders, through: :creatures_orders
  # validates :organization, presence: true
  def retire
    update_attribute(:retired, true)
  end
end
