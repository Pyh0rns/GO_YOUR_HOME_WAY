# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# -------------------------------------
p "destroy documents"
Document.destroy_all
p "documents destroyed"

p "destroy properties"
Property.destroy_all
p "properties destroyed"

# -------------------------------------
p "destroy users"
User.destroy_all
p "users destroyed"

# -------------------------------------
p "create users"
py = User.create!(email: "py@mail.com", password: "coucou")
karine = User.create!(email: "karine@mail.com", password: "coucou")
p "users created"

# -------------------------------------
p "create properties"
Property.create!(name: "Appart Magasin", address: "Lille", buying_date:'01-03-2020', buying_price: 200000, user: py)
pottier = Property.create!(name: "Maison Pottier", address: "Lambersart", buying_date:'01-06-2023', buying_price: 200000, user: py)
Property.create!(name: "Maison St Remy", address: "Saint Remy les Chevreuses", buying_date:'01-06-2023', buying_price: 400000, user: karine)
p "properties created"

# -------------------------------------
p "create document categories"
  ['Photo', 'DPE', 'Facture', 'Devis'].each do |category_name|
    DocumentCategory.find_or_create_by(name: category_name)
  end
p "document categories created"


# -------------------------------------
p "create documents"
Document.create!(name: "Placo", description: "J'ai fait du placo", property: pottier, document_category: DocumentCategory.first, date: Date.today)
Document.create!(name: "Devis Elec", description: "Le devis signé pour l'électricité", property: pottier, document_category: DocumentCategory.last, date: '01-09-2023' )
p "documents created"
