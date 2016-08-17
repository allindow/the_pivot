class Recipient < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  belongs_to :type
  has_many :recipient_fundings
  has_many :orders, through: :recipient_fundings

  # validates :type, presence: true
  def retire
    update_attribute(:retired, true)
  end
end
