class Comment < ApplicationRecord
  validates :title, :content, presence: true
  belongs_to :user, optional: true
  belongs_to :company, optional: true
  belongs_to :micropost, optional: true
  has_many :notifications, dependent: :destroy
  has_many :images, as: :imageable
  accepts_nested_attributes_for :images
end
