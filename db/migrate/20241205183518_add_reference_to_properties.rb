class AddReferenceToProperties < ActiveRecord::Migration[8.0]
  def change
    add_reference :properties, :user, foreign_key: true
  end
end
