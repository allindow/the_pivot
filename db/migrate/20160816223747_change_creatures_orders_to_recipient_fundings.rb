class ChangeCreaturesOrdersToRecipientFundings < ActiveRecord::Migration
  def change
    rename_table :creatures_orders, :recipient_fundings
  end
end
