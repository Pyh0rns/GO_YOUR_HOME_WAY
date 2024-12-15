class CreateActions < ActiveRecord::Migration[8.0]
  def change
    create_table :work_actions do |t|
      t.string :name
      t.string :description
      t.date :date
      t.references :action_category
      t.references :property
      t.belongs_to :actionable, polymorphic: true

      t.timestamps
    end
  end
end
