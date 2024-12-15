class CreateDocuments < ActiveRecord::Migration[8.0]
  def change
    create_table :documents do |t|
      t.references :property, null: false, foreign_key: true
      t.references :document_category, null: false, foreign_key: true
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
