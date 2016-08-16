class ChangeCreaturesToRecipients < ActiveRecord::Migration
  def change
    rename_table :creatures, :recipients
  end
end
