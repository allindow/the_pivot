class AddCountryToRecipients < ActiveRecord::Migration
  def change
    add_column :recipients, :country, :string
  end
end
