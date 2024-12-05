# PY: create document categories when the app starts

Rails.application.config.after_initialize do
  ['DPE', 'Devis', 'Facture'].each do |category_name|
    DocumentCategory.find_or_create_by(name: category_name)
  end
end
