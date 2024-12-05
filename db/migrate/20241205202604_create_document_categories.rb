class CreateDocumentCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :document_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
