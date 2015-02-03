class CreateTicketTypes < ActiveRecord::Migration
  def change
    create_table :ticket_types do |t|
      t.references :event
      t.decimal :price, :scale => 2

      t.timestamps
    end
    add_index :ticket_types, :event_id
  end
end
