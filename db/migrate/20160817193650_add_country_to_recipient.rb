class AddCountryToRecipient < ActiveRecord::Migration
  def change
    add_reference :recipients, :country, index: true, foreign_key: true
  end
end
