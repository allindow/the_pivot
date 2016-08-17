class Order < ActiveRecord::Base
  has_many :recipient_fundings
  has_many :creatures, through: :recipient_fundings
  belongs_to :user
  # after_update :assign_total_price

  def order_details
    order_items = RecipientsOrder.where(order_id: self.id)
    order_details = {}
    order_items.each do |item|
      name = Recipient.find(item.recipient_id).name
      price = Recipient.find(item.recipient_id).price
      qty = item.quantity
      order_details[name] = [price, qty] unless qty == 0
    end
    order_details
  end

  def total_price
    total_price = 0
    order_details.each do |key, value|
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

  def self.order_status(status)
    self.all.where(status: status).count
  end

  def update_status(status)
    update_attributes(status: status.downcase)
  end
end
