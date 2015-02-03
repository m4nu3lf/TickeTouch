class AddAvailabilityToTicketType < ActiveRecord::Migration
  def change
    add_column :ticket_types, :availability, :integer
  end
end
