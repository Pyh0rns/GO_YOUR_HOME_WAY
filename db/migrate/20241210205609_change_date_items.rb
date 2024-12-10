class ChangeDateItems < ActiveRecord::Migration[7.1]
  def change
    change_column :list_items, :deadline, :datetime
  end
end
