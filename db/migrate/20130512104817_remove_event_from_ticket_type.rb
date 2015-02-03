class RemoveEventFromTicketType < ActiveRecord::Migration
  def up
    remove_column :ticket_types, :event_id
  end

  def down
    add_column :ticket_types, :event_id, :references
  end
end
