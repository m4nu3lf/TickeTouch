class RemoveSiteFromEvents < ActiveRecord::Migration
  def up
    remove_column :events, :site_id
  end

  def down
    add_column :events, :site_id, :references
  end
end
