class AddFundingAndRecipientToRecipientFundings < ActiveRecord::Migration
  def change
    add_reference :recipient_fundings, :recipient, index: true, foreign_key: true
    add_reference :recipient_fundings, :funding, index: true, foreign_key: true
  end
end
