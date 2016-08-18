class RemoveCountryFromRecipient < ActiveRecord::Migration
  def change
    remove_column :recipients, :country
  end
end
