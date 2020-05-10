class Comment < ApplicationRecord
  belongs_to :company
  belongs_to :micropost,optional: true
end
