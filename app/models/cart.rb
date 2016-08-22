class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents ||= {}
  end

  def add_recipient(recipient_id, loan_amount)
    contents[recipient_id.to_s] ||= 0
    contents[recipient_id.to_s] += loan_amount.to_i
  end

  def count_of(recipient_id)
    contents[recipient_id.to_s]
  end

  def total # total_quantity
    contents.values.sum
  end

  def recipients
    recipients = []
    contents.keys.each do |id|
      recipients << Recipient.find(id) unless contents[id] == 0
    end
    recipients
  end

  def subtotal(recipient_id)
    contents[recipient_id.to_s] * Recipient.find(recipient_id).price
  end

  def empty?
    contents.values.sum == 0 || nil?
  end

  def not_empty?
    empty? == false
  end
end
