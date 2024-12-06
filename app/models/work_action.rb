class WorkAction < ApplicationRecord
  belongs_to :actionable, polymorphic: true
  belongs_to :property
  belongs_to :action_category

end
