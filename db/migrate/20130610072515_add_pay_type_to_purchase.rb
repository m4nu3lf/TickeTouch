class AddPayTypeToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :pay_type, :string
  end
end
