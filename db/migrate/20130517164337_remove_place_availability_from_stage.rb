class RemovePlaceAvailabilityFromStage < ActiveRecord::Migration
  def up
    remove_column :stages, :place_availability
  end

  def down
    add_column :stages, :place_availability, :integer
  end
end
