class Micropost < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true
  has_many :images
  accepts_nested_attributes_for :images
end
