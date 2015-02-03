class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.string :surname
      t.string :art_name
      t.text :biography

      t.timestamps
    end
  end
end
