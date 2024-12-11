class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.references :company, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true
      t.string :description
      t.date :date

      t.timestamps
    end
  end
end
