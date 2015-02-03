class AddKeyCodeToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :key_code, :string
  end
end
