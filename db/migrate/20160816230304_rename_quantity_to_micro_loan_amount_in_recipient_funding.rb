class RenameQuantityToMicroLoanAmountInRecipientFunding < ActiveRecord::Migration
  def change
    rename_column :recipient_fundings, :quantity, :microloan_amount
  end
end
