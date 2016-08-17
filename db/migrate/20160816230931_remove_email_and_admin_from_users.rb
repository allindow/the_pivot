class RemoveEmailAndAdminFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :email
    remove_column :users, :admin
  end
end
