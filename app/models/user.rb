class User < ApplicationRecord
  validates :name, :email, uniqueness: { case_sensitive: :false }, presence: true
  has_many :microposts, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_microposts, through: :favorites, source: :micropost
  # has_many :notifications, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitorable_id', dependent: :destroy, as: :visitorable
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visitedable_id', dependent: :destroy, as: :visitedable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(name: 'sample user', email: 'guestuser@guest.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
