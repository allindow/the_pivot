class ChangeAmountReceivedDefault < ActiveRecord::Migration
  def change
    change_column :recipients, :amount_received, :decimal, :default => 0
  end
end
