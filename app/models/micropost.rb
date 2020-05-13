class Micropost < ApplicationRecord
  belongs_to :user
  has_many :images, as: :imageable
  has_many :comments
  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
  accepts_nested_attributes_for :images
end
