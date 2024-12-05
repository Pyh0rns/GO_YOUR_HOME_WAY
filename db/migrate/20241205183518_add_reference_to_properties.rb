class AddReferenceToProperties < ActiveRecord::Migration[7.1]
  def change
    add_reference :properties, :user, foreign_key: true
  end
end
