class AddLatitudeToSite < ActiveRecord::Migration
  def change
    add_column :sites, :latitude, :float
  end
end
