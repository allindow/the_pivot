class Creature < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  
  belongs_to :type  
  has_many :creatures_orders
  has_many :orders, through: :creatures_orders
  # validates :type, presence: true
  def retire
    update_attribute(:retired, true)
  end
end