class Document < ApplicationRecord
  belongs_to :property
  belongs_to :document_category
  has_one_attached :photo

end
