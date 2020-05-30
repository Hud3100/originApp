class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  mount_uploader :img, ImgUploader
  validates :img, presence: true
end
