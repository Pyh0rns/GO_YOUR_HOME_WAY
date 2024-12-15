class AddInfosToCompanies < ActiveRecord::Migration[8.0]
  def change
    add_column :companies, :name, :string
    add_column :companies, :address, :string
    add_column :companies, :phone_number, :string
    add_column :companies, :longitude, :float
    add_column :companies, :latitude, :float
    add_column :companies, :rating, :integer
  end
end
