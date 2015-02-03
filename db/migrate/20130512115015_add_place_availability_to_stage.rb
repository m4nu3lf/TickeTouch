class AddPlaceAvailabilityToStage < ActiveRecord::Migration
  def change
    add_column :stages, :place_availability, :integer
  end
end
