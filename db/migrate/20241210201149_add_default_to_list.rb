class AddDefaultToList < ActiveRecord::Migration[7.1]
  def change
    change_column_default :list_items, :done, false
  end
end
