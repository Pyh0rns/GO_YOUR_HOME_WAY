class AddSurfaceAndNumberOfRoomsToProperties < ActiveRecord::Migration[8.0]
  def change
    add_column :properties, :surface, :integer
    add_column :properties, :number_of_rooms, :integer
  end
end
