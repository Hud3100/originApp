class Category < ApplicationRecord
  validates :name, presence: true
  has_many :micropost_category_relations
  has_many :microposts, through: :micropost_category_relations
end
