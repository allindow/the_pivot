class RemoveCreatureIdAndOrderIdFromRecipients < ActiveRecord::Migration
  def change
    remove_column :recipient_fundings, :creature_id
    remove_column :recipient_fundings, :order_id
  end
end
