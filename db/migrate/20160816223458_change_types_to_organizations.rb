class ChangeTypesToOrganizations < ActiveRecord::Migration
  def change
    rename_table :types, :organizations
  end
end
