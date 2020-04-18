class Image < ApplicationRecord
  belongs_to :micropost
  mount_uploader :img, ImgUploader
end
