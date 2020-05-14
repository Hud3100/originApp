class Micropost < ApplicationRecord
  belongs_to :user
  has_many :images, as: :imageable
  has_many :comments
  has_many :favorites
  has_many :notifications, as: :notificationable, dependent: :destroy
  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
  accepts_nested_attributes_for :images

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def create_notification_comment!(current_company, comment_id)
    temp_ids = Comment.select(:company_id).where(micropost_id: id).where.not(company_id: current_company.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_company, comment_id, temp_id['company_id'])
    end
    save_notification_comment!(current_company, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_company, comment_id, visitedable_id)
    notification = current_company.active_notifications.new(
      micropost_id: id,
      comment_id: comment_id,
      visitedable_id: visitedable_id,
      action: 'comment'
    )
    if notification.visitorable_id == notification.visitedable_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  def create_notification_favorite!(current_user)
    temp = Notification.where(["visitorable_id = ? and visitedable_id = ? and micropost_id = ? and action = ?", current_user.id, user_id, id, 'favorite'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        micropost_id: id,
        visitedable_id: user_id,
        action: 'favorite'
      )
      if notification.visitorable_id == notification.visitedable_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
end

# def create_notification_comment!(current_company, comment_id)
#   temp_ids = Comment.select(:commentable_id).where(micropost_id: id).where.not(commentable_id: current_model.id).distinct
#   temp_ids.each do |temp_id|
#     save_notification_comment!(current_model, comment_id, temp_id['commentable_id'])
#   end
#   save_notification_comment!(current_company, comment_id, commentable_id) if temp_ids.blank?
# end

# def save_notification_comment!(current_company, comment_id, visitedable_id)
#   notification = current_company.active_notifications.new(
#     micropost_id: id,
#     comment_id: comment_id,
#     visitedable_id: visitedable_id,
#     action: 'comment'
#   )
#   if notification.visitorable_id == notification.visitedable_id
#     notification.checked = true
#   end
#   notification.save if notification.valid?
# end