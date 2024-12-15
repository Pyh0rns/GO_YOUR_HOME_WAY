class AddDateToDocuments < ActiveRecord::Migration[8.0]
  def change
    add_column :documents, :date, :date
  end
end
