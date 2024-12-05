# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# PY : essayer de faire la seed de User dans config/initializers plus tard
p "destroy properties"
Property.destroy_all
p "properties destroyed"

p "destroy users"
User.destroy_all
p "users destroyed"

p "create users"
py = User.create!(email: "py@mail.com", password: "coucou")
p "users created"

p "create properties"
Property.create!(name: "Appart Magasin", address: "Lille", buying_date:'01-03-2020', buying_price: 200000, user: py)
Property.create!(name: "Maison Pottier", address: "Lambersart", buying_date:'01-06-2023', buying_price: 200000, user: py)
p "properties created"
