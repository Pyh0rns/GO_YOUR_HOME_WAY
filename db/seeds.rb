# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
require 'json'

p 'destroy appointments'
Appointment.destroy_all
p 'appointments destroyed'

# -------------------------------------
p 'destroy list items'
ListItem.destroy_all
p 'list items destroyed'

# -------------------------------------
p 'destroy favorites'
Favorite.destroy_all
p 'favorites destroyed'

# -------------------------------------
p 'destroy actions'
WorkAction.destroy_all
p 'actions destroyed'

# -------------------------------------
p 'destroy companies'
Company.destroy_all
p 'companies destroyed'

# -------------------------------------
p 'destroy documents'
Document.destroy_all
p 'documents destroyed'

# -------------------------------------
p 'destroy properties'
Property.destroy_all
p 'properties destroyed'

# -------------------------------------
p 'destroy property categories'
PropertyCategory.destroy_all
p 'property categories destroyed'

# -------------------------------------
p 'destroy users'
User.destroy_all
p 'users destroyed'

# -------------------------------------
p 'create users'
py = User.create!(email: 'py@mail.com', password: 'coucou')
karine = User.create!(email: 'karine@mail.com', password: 'coucou')
p 'users created'

# -------------------------------------
p 'create property_categories'
principale = PropertyCategory.create!(name: "Résidence principale")
PropertyCategory.create!(name: "Résidence secondaire")
loc = PropertyCategory.create!(name: "En location")
PropertyCategory.create!(name: "Vide")
p 'property_categories created'


# -------------------------------------
p 'create properties'
Property.create!(
  name: 'Appart Magasin',
  address: 'Rue du Magasin, 59800, Lille',
  buying_date: '01-03-2020',
  buying_price: 200_000,
  user: py,
  property_category: loc
)
pottier =
  Property.create!(
    name: 'Maison Pottier',
    address: 'Avenue Pottier, 59130, Lambersart',
    buying_date: '01-06-2023',
    buying_price: 200_000,
    user: py,
    property_category: principale
  )

Property.create!(
  name: 'Maison St Remy',
  address: 'Rambouillet',
  buying_date: '01-06-2023',
  buying_price: 400_000,
  user: karine,
  property_category: principale
)
p 'properties created'

# -------------------------------------
p 'create document categories'
%w[Photo DPE Facture Devis Plan Autre].each do |category_name|
  DocumentCategory.find_or_create_by(name: category_name)
end
p 'document categories created'

# -------------------------------------
p 'create documents'
doc =
  Document.create!(
    name: 'Devis Plomberie',
    description: 'Le devis signé pour la plomberie',
    property: pottier,
    document_category: DocumentCategory.find_by(name: 'Devis'),
    date: '01-11-2024',
  )
image_path = Rails.root.join('app', 'assets', 'images', 'devis.webp')
doc.photo.attach(io: File.open(image_path), filename: 'devis.webp')
doc =
  Document.create!(
    name: 'Devis Elec',
    description: "Le devis signé pour l'électricité",
    property: pottier,
    document_category: DocumentCategory.find_by(name: 'Devis'),
    date: '03-11-2024',
  )
image_path = Rails.root.join('app', 'assets', 'images', 'devis.webp')
doc.photo.attach(io: File.open(image_path), filename: 'devis.webp')
doc =
  Document.create!(
    name: 'Facture isolant',
    description: "Facture laine de verre",
    property: pottier,
    document_category: DocumentCategory.find_by(name: 'Facture'),
    date: '12-11-2024',
  )
image_path = Rails.root.join('app', 'assets', 'images', 'facture_template.jpg')
doc.photo.attach(io: File.open(image_path), filename: 'facture_template.jpg')
p 'documents created'

# -------------------------------------
p 'create companies'
elec = Company.create!(
  email: 'electron@mail.com',
  password: 'coucou',
  name: 'Electron libre',
  address: 'Lille',
  phone_number: '01 47 20 00 01',
  rating: 5,
)
plomberie = Company.create!(
  email: 'plomberie@mail.com',
  password: 'coucou',
  name: 'Plombier du Nord',
  address: 'Lambersart',
  phone_number: '01 47 20 00 01',
  rating: 5,
)
p 'companies created'

# -------------------------------------
p 'create action categories'
%w[
  Electricité
  Plomberie
  Peinture
  Isolation
  Décoration
  Autre
].each { |category_name| ActionCategory.find_or_create_by(name: category_name) }
p 'action categories created'

# -------------------------------------
p 'create real companies'
file_path = Rails.root.join('db', 'companies.json')
serialized_companies = File.read(file_path)
companies = JSON.parse(serialized_companies)

# companies.each do |company|
#   unless company["name"].empty?
#     # le mail random peut faire péter les seed si pas de chance. Juste relancer et ça devrait marcher
#     being_created = Company.create!(email: "#{company["name"].split.join + ("a".."z").to_a.sample}@mail.com", password: "coucou", name: company["name"], address: company["address"])
#   end
#   # A AJOUTER PLUS TARD LORS DE L'AJOUT DE CATEGORIES AUX COMPANIES
#   # being_created.category = Category.find_by(name: company["category"])
#   # being_created.save
# end

#
companies.each do |company|
  unless company['name'].empty?
    # Extraction du nom de ville
    city = company['address'].split('(').first.strip

    Company.create!(
      email: "#{company['name'].gsub(/\W+/, '').downcase}#{rand(100)}@mail.com",
      password: 'coucou',
      name: company['name'],
      address: city,
    )
    # A AJOUTER PLUS TARD LORS DE L'AJOUT DE CATEGORIES AUX COMPANIES
    #   # being_created.category = Category.find_by(name: company["category"])
    #   # being_created.save
  end
end

p 'real companies created'

# -------------------------------------
p 'create actions'
action =
  WorkAction.create!(
    name: 'Tableau électrique',
    description: 'Tableau électrique terminé',
    date: Date.today - 5,
    action_category: ActionCategory.find_by(name: 'Electricité'),
    property: pottier,
    actionable: Company.first,
  )
image_paths = [
  Rails.root.join('app', 'assets', 'images', 'elec.jpeg'),
  Rails.root.join('app', 'assets', 'images', 'elec2.jpg'),
]
action.photos.attach(
  image_paths.map do |path|
    { io: File.open(path), filename: File.basename(path) }
  end,
)

action =
  WorkAction.create!(
    name: 'Enduit',
    description: 'Enduit mur droit extension terminé',
    date: Date.today - 2,
    action_category: ActionCategory.find_by(name: 'Autre'),
    property: pottier,
    actionable: User.first,
  )
image_paths = [Rails.root.join('app', 'assets', 'images', 'placo.jpeg')]
action.photos.attach(
  image_paths.map do |path|
    { io: File.open(path), filename: File.basename(path) }
  end,
)
p 'actions created'

# -------------------------------------
p 'create favorites'
Favorite.create!(property: pottier, company: elec)
Favorite.create!(property: pottier, company: plomberie)
p 'favorites created'

# -------------------------------------
p 'create list items'
ListItem.create!(property: pottier, title: 'ranger', deadline: Date.today)
ListItem.create!(property: pottier, title: 'acheter un tournevis', deadline: Date.today + 1)
ListItem.create!(property: pottier, title: 'peinture 2e étage', deadline: Date.today + 4)
p 'list items created'

# -------------------------------------
p 'create appointments'
Appointment.create!(property: pottier, company: elec, description: 'prise de contact', date: Date.today + 3)
Appointment.create!(property: pottier, company: plomberie, description: 'RDV pour un devis', date: Date.today + 7)
p 'appointments created'
# -------------------------------------
p 'ALL GOOD'
