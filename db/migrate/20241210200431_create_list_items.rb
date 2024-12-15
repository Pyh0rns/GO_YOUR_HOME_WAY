class CreateListItems < ActiveRecord::Migration[8.0]
  def change
    create_table :list_items do |t|
      t.string :title
      t.boolean :done
      t.date :deadline
      t.references :property, null: false, foreign_key: true

      t.timestamps
    end
  end
end
