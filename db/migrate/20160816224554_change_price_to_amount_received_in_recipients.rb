class ChangePriceToAmountReceivedInRecipients < ActiveRecord::Migration
  def change
    rename_column :recipients, :price, :amount_received
  end
end
