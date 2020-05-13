class Comment < ApplicationRecord
  belongs_to :company
  belongs_to :micropost,optional: true
  validates :content, presence: true
  has_many :images, as: :imageable
  accepts_nested_attributes_for :images
end
