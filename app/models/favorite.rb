class Favorite < ApplicationRecord
  belongs_to :company
  belongs_to :property
end
