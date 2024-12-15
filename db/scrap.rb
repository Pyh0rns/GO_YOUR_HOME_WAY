require "open-uri"
require "nokogiri"
require "json"

companies = []

# ELEC

url = "https://www.bonjour-artisan.net/annuaire/recherche?utf8=%E2%9C%93&q=%C3%89lectricit%C3%A9+g%C3%A9n%C3%A9rale&location=Lille&search=&extra_data="
html_file = URI.parse(url).read
html_doc = Nokogiri::HTML.parse(html_file)

html_doc.search(".panel").each do |element|
  name = element.search("h2").text.strip
  address = element.search(".address").text.strip
  category = "Electricité"
  companies << { name: name, address: address, category: category }
end

# PLOMBERIE

url = "https://www.bonjour-artisan.net/annuaire/recherche?utf8=%E2%9C%93&q=Plomberie+g%C3%A9n%C3%A9rale&location=Lille&search=&extra_data="
html_file = URI.parse(url).read
html_doc = Nokogiri::HTML.parse(html_file)

html_doc.search(".panel").each do |element|
  name = element.search("h2").text.strip
  address = element.search(".address").text.strip
  category = "Plomberie"
  companies << { name: name, address: address, category: category }
end

companies_hash = {
  companies: []
}

companies.each do |company|
  companies_hash[:companies] << company
end

File.open("./companies.json", "wb") do |file|
  file.write(JSON.generate(companies))
end
