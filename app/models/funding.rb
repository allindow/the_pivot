class Funding < ActiveRecord::Base
  has_many :recipient_fundings
  has_many :recipients, through: :recipient_fundings
  belongs_to :user

  def update_recipient_total(id, microloan)
    recipient = Recipient.find(id)
    recipient.update(amount_received: new_total(recipient, microloan))
  end

  def new_total(recipient, microloan)
    recipient.amount_received.to_i + microloan.to_i
  end

  def total_price
    recipient_fundings.map do |funding|
      funding.microloan_amount
    end.sum
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

  def update_amount_received(recipient, funding)
    new_amount = recipient.amount_received.to_i + funding.microloan_amount.to_i
    recipient.update(amount_received: new_amount)
  end
end
