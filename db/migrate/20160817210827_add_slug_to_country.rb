class AddSlugToCountry < ActiveRecord::Migration
  def change
    add_column :countries, :slug, :string
  end
end
