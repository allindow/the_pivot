<<<<<<< HEAD
class Funding < ActiveRecord::Base
  has_many :recipient_fundings
  has_many :recipients, through: :recipient_fundings
  belongs_to :user

  def funding_details
    funding_items = RecipientFundings.where(funding_id: self.id)
    funding_details = {}
    funding_items.each do |item|
      username = Recipient.find(item.recipient_id).username
      amount_received = Recipient.find(item.recipient_id).amount_received
      qty = item.quantity
      funding_details[name] = [price, qty] unless qty == 0
    end
    funding_details
  end

  def total_price
    total_price = 0
    funding_details.each do |key, value|
      total_price += value.reduce(:*)
    end
    total_price
  end

  def assign_total_price
    update_attribute(:total_price, total_price.to_i.to_f)
  end

  def completed?
    status == "completed"
  end

  def canceled?
    status == "canceled"
  end

  def self.funding_status(status)
    self.all.where(status: status).count
  end

  def update_status(status)
    update_attributes(status: status.downcase)
  end
end
