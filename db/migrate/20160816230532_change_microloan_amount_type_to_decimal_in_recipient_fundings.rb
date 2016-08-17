class ChangeMicroloanAmountTypeToDecimalInRecipientFundings < ActiveRecord::Migration
  def change
    change_column :recipient_fundings, :microloan_amount, :decimal
  end
end
