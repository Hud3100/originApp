class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_many :comments, as: :commentable
  has_many :favorites
  has_many :favorite_microposts, through: :favorites, source: :micropost
  has_many :notifications
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitorable_id', dependent: :destroy, as: :visitorable
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visitedable_id', dependent: :destroy, as: :visitedable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
