class Notification < ApplicationRecord
  belongs_to :micropost, optional: true
  belongs_to :comment, optional: true
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitorable_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visitedable_id', optional: true
end
