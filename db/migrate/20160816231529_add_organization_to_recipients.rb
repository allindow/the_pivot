class AddOrganizationToRecipients < ActiveRecord::Migration
  def change
    add_reference :recipients, :organization, index: true, foreign_key: true
  end
end
