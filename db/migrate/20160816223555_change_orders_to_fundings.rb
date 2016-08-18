class ChangeOrdersToFundings < ActiveRecord::Migration
  def change
    rename_table :orders, :fundings
  end
end
