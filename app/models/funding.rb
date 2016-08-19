class Funding < ActiveRecord::Base
  has_many :recipient_fundings
  has_many :recipients, through: :recipient_fundings
  belongs_to :user

  def funding_details
    funding_recipients = RecipientFunding.where(funding_id: self.id)
    funding_details = {}
    funding_recipients.each do |funding|
      recipient = Recipient.find(funding.recipient_id)
      update_amount_received(recipient, funding)
      name = recipient.name
      funding_amount = funding.microloan_amount.to_i
      funding_details[name] = [funding_amount] unless funding_amount == 0
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

  def update_amount_received(recipient, funding)
    new_amount = recipient.amount_received.to_i + funding.microloan_amount.to_i
    recipient.update(amount_received: new_amount)
  end
end
