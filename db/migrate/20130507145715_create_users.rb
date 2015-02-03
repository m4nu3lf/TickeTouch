class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :email
      t.string :name
      t.string :surname
      t.string :address
      t.string :tel_number
      t.boolean :admin

      t.timestamps
    end
  end
end
