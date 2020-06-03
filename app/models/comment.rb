class Comment < ApplicationRecord
  validates :title, :content, :micropost_id, presence: true
  belongs_to :commentable, polymorphic: true
  belongs_to :micropost, optional: true
  has_many :notifications, dependent: :destroy
  has_many :images, as: :imageable
  accepts_nested_attributes_for :images
end
