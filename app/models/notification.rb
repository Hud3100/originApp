class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  validates :action, :visitorable_type, :visitedable_type, presence: true
  belongs_to :micropost, optional: true
  belongs_to :comment, optional: true
  belongs_to :visitorable_user, class_name: 'User', foreign_key: 'visitorable_id', optional: true
  belongs_to :visitedable_user, class_name: 'User', foreign_key: 'visitedable_id', optional: true
  belongs_to :visitorable_company, class_name: 'Company', foreign_key: 'visitorable_id', optional: true
  belongs_to :visitedable_company, class_name: 'Company', foreign_key: 'visitedable_id', optional: true
end
