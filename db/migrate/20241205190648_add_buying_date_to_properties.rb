class AddBuyingDateToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :buying_date, :date
  end
end
