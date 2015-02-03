class AddStageToTicketType < ActiveRecord::Migration
  def change
    add_column :ticket_types, :stage_id, :integer
  end
end
