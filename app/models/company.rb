class Company < ApplicationRecord
  has_many :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :notrifications, as: :notificationable
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitorable_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visitedable_id', dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
