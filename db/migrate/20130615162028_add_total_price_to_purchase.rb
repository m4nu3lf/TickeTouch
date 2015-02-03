class AddTotalPriceToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :total_price, :float
  end
end
