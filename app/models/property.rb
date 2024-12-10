class Property < ApplicationRecord
  belongs_to :user
  has_many :documents
  has_many :work_actions
  has_many :favorites
  has_many :list_items
  has_many :companies, through: :favorites

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
