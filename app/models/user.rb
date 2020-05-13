class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_many :favorites
  has_many :favorite_microposts, through: :favorites, source: :micropost
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
