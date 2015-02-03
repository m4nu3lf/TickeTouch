class RemovePlaceAvalaibilityFromStage < ActiveRecord::Migration
  def up
    remove_column :stages, :place_avalaibility
  end

  def down
    add_column :stages, :place_avalaibility, :integer
  end
end
