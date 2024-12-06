class Property < ApplicationRecord
  belongs_to :user
  has_many :documents
  has_many :work_actions
end
