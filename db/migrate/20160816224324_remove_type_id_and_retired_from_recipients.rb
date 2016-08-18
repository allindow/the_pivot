class RemoveTypeIdAndRetiredFromRecipients < ActiveRecord::Migration
  def change
    remove_column :recipients, :type_id
    remove_column :recipients, :retired
  end
end
