class AddDefaultToList < ActiveRecord::Migration[8.0]
  def change
    change_column_default :list_items, :done, false
  end
end
