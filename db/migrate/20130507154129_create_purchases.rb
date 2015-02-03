class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.references :user
      t.timestamp :datetime

      t.timestamps
    end
    add_index :purchases, :user_id
  end
end
