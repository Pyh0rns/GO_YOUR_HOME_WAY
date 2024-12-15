class ChangeDateItems < ActiveRecord::Migration[8.0]
  def change
    change_column :list_items, :deadline, :datetime
  end
end
