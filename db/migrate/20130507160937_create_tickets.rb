class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.references :ticket_type
      t.references :purchase

      t.timestamps
    end
    add_index :tickets, :ticket_type_id
    add_index :tickets, :purchase_id
  end
end
