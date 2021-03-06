class Micropost < ApplicationRecord
  belongs_to :user
  has_many :images, as: :imageable, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :micropost_category_relations, dependent: :destroy
  has_many :categories, through: :micropost_category_relations
  validates :user_id, presence: true
  validates :title, :content, presence: true
  validates :content, uniqueness: true
  accepts_nested_attributes_for :images, allow_destroy: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def create_notification_comment_for_user!(current_user, comment_id, commentable_type, visitedable_id)
    temp_ids = Comment.select(:commentable_id, :commentable_type).where(micropost_id: id).where.not(commentable_id: current_user.id, commentable_type: commentable_type).distinct
    temp_ids.each do |temp_id|
      save_notification_comment_for_user!(current_user, comment_id, temp_id, visitedable_id)
    end
    save_notification_comment_for_user!(current_user, comment_id, user_id, visitedable_id) if temp_ids.blank?
  end

  def save_notification_comment_for_user!(current_user, comment_id, temp_id, visitedable_id)
    notification = current_user.active_notifications.new(
      micropost_id: id,
      comment_id: comment_id,
      visitedable_id: visitedable_id,
      visitedable_type: "User",
      action: 'comment'
    )
    if notification.visitorable_id == notification.visitedable_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  def create_notification_comment!(current_company, comment_id, commentable_type, visitedable_id)
    temp_ids = Comment.select(:commentable_id, :commentable_type).
      where(micropost_id: id).
      where.not(commentable_id: current_company.id, commentable_type: commentable_type).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_company, comment_id, temp_id, visitedable_id)
    end
    save_notification_comment!(current_company, comment_id, user_id, visitedable_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_company, comment_id, temp_id, visitedable_id)
    notification = current_company.active_notifications.new(
      micropost_id: id,
      comment_id: comment_id,
      visitedable_id: visitedable_id,
      visitedable_type: "User",
      action: 'comment'
    )
    if notification.visitorable_id == notification.visitedable_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  def create_notification_favorite!(current_user)
    temp = Notification.where(["visitorable_id = ? and visitedable_id = ? and visitorable_type = ? and micropost_id = ? and action = ?", current_user.id, user_id, "User", id, 'favorite'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        micropost_id: id,
        visitedable_id: user_id,
        visitedable_type: "User",
        action: 'favorite'
      )
      if notification.visitorable_id == notification.visitedable_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
end
