class MicropostCategoryRelation < ApplicationRecord
  belongs_to :micropost
  belongs_to :category
end
