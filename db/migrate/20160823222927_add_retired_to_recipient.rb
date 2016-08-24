class AddRetiredToRecipient < ActiveRecord::Migration
  def change
    add_column :recipients, :retired, :boolean, default: false
  end
end
