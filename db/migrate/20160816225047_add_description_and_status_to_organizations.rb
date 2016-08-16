class AddDescriptionAndStatusToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :status, :integer, default: 0
    add_column :organizations, :description, :text
  end
end
