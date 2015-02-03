class AddDescriptionToTicketType < ActiveRecord::Migration
  def change
    add_column :ticket_types, :description, :string
  end
end
