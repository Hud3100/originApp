class Company < ApplicationRecord
  validates :name, presence: true
  has_many :comments, as: :commentable
  has_many :notifications, as: :notificationable
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitorable_id', dependent: :destroy, as: :visitorable
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visitedable_id', dependent: :destroy, as: :visitedable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
