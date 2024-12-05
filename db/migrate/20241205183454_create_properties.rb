class CreateProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.integer :buying_price
      t.integer :fee_price
      t.integer :action_price
      t.integer :total_price

      t.timestamps
    end
  end
end
