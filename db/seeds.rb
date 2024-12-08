# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

# -------------------------------------
p "destroy actions"
WorkAction.destroy_all
p "actions destroyed"

# -------------------------------------
p "destroy companies"
Company.destroy_all
p "companies destroyed"

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
  ['Photo', 'DPE', 'Facture', 'Devis', 'Plan', 'Autre'].each do |category_name|
    DocumentCategory.find_or_create_by(name: category_name)
  end
p "document categories created"

# -------------------------------------
p "create documents"
doc = Document.create!(name: "Devis Plomberie", description: "Le devis signé pour la plomberie", property: pottier, document_category: DocumentCategory.find_by(name: "Devis"), date: '01-09-2023')
image_path = Rails.root.join('app', 'assets', 'images', 'devis.webp')
doc.photo.attach(io: File.open(image_path), filename: 'devis.webp')
doc = Document.create!(name: "Devis Elec", description: "Le devis signé pour l'électricité", property: pottier, document_category: DocumentCategory.find_by(name: "Devis"), date: '03-09-2023' )
image_path = Rails.root.join('app', 'assets', 'images', 'devis.webp')
doc.photo.attach(io: File.open(image_path), filename: 'devis.webp')
p "documents created"

# -------------------------------------
p "create companies"
Company.create!(email: "electron@mail.com", password: "coucou", name: "Electron libre", address: "Lille", phone_number: "01 47 20 00 01", rating: 5)
p "companies created"

# -------------------------------------
p "create action categories"
  ['Electricité', 'Plomberie', 'Peinture', 'Isolation', 'Décoration', 'Autre'].each do |category_name|
    ActionCategory.find_or_create_by(name: category_name)
  end
p "action categories created"


# -------------------------------------
p "create actions"
action = WorkAction.create!(name:"Tableau électrique", description: "Tableau électrique terminé", date: Date.today, action_category: ActionCategory.find_by(name:"Electricité"), property: pottier, actionable: Company.first)
image_paths = [Rails.root.join('app', 'assets', 'images', 'elec.jpeg')]
action.photos.attach(
  image_paths.map { |path| { io: File.open(path), filename: File.basename(path) } }
)

action = WorkAction.create!(name:"Enduit", description: "Enduit mur droit extension terminé", date: Date.today, action_category: ActionCategory.find_by(name:"Autre"), property: pottier, actionable: User.first)
image_paths = [Rails.root.join('app', 'assets', 'images', 'placo.jpeg')]
action.photos.attach(
  image_paths.map { |path| { io: File.open(path), filename: File.basename(path) } }
)
p "actions created"
