class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.references :event
      t.references :site
      t.integer :place_avalaibility
      t.datetime :date_time

      t.timestamps
    end
    add_index :stages, :event_id
    add_index :stages, :site_id
  end
end
