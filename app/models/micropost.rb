class Micropost < ApplicationRecord
  belongs_to :user
  has_many :images, as: :imageable
  has_many :comments
  has_many :favorites
  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
  accepts_nested_attributes_for :images

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
