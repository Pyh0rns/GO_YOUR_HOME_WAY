class AddCategoryToProperties < ActiveRecord::Migration[7.1]
  def change
    add_reference :properties, :property_category, foreign_key: true
  end
end
