class AddBuyingDateToProperties < ActiveRecord::Migration[8.0]
  def change
    add_column :properties, :buying_date, :date
  end
end
