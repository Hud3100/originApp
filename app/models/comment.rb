class Comment < ApplicationRecord
  belongs_to :company, optional: true
  belongs_to :micropost, optional: true
  validates :content, presence: true
  has_many :notifications, dependent: :destroy
  has_many :images, as: :imageable
  accepts_nested_attributes_for :images
end
