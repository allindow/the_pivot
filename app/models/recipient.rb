class Recipient < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  
  belongs_to :type  
  has_many :recipients_orders
  has_many :orders, through: :recipients_orders
  # validates :type, presence: true
  def retire
    update_attribute(:retired, true)
  end
end