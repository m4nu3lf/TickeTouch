class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :site
      t.text :description
      t.datetime :time
      t.integer :place_number

      t.timestamps
    end
    add_index :events, :site_id
  end
end
