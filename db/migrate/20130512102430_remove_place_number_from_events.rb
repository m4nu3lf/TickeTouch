class RemovePlaceNumberFromEvents < ActiveRecord::Migration
  def up
    remove_column :events, :place_number
  end

  def down
    add_column :events, :place_number, :integer
  end
end
