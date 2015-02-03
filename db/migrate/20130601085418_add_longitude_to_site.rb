class AddLongitudeToSite < ActiveRecord::Migration
  def change
    add_column :sites, :longitude, :float
  end
end
