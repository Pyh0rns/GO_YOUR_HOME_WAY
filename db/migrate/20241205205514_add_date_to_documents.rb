class AddDateToDocuments < ActiveRecord::Migration[7.1]
  def change
    add_column :documents, :date, :date
  end
end
