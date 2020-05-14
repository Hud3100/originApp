class Micropost < ApplicationRecord
  belongs_to :user
  has_many :images, as: :imageable
  has_many :comments
  has_many :favorites
  has_many :notifications, dependent: :destroy
  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
  accepts_nested_attributes_for :images

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(micropost_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      micropost_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  def create_notification_favorite!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and micropost_id = ? and action = ?", current_user.id, user_id, id, 'favorite'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        micropost_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
end
