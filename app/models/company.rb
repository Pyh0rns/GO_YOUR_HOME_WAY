class Company < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  has_many :work_actions, as: :actionable
  has_many :favorites
  has_many :appointments
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model

  # ajouter plus tard recherche par localisation et spécialité
  pg_search_scope :search,
                  against: %i[name address],
                  using: {
                    tsearch: {
                      prefix: true,
                    },
                  }
end
