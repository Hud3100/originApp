require 'rails_helper'
RSpec.describe Notification, type: :model do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:company) { create(:company) }
  let(:micropost) { create(:micropost) }
  context "お気に入りの通知:" do
    it "ユーザーが投稿にお気に入り登録したときにNotificationモデルが生成される" do
      expect { micropost.create_notification_favorite!(user) }.to change{ Notification.count }.by(1)
    end
  end

  context "クラスメソッドのテスト:" do
    it "ユーザーが投稿にコメントしたときNotificationモデルが生成される" do
      comment = user.comments.create(micropost_id: micropost.id)
      expect { micropost.create_notification_comment_for_user!(user, comment.id, "user") }.to change{ Notification.count }.by(1)
    end

    it "カンパニーが投稿にコメントしたときNotificationモデルが生成される" do
      comment = company.comments.create(micropost_id: micropost.id)
      expect { micropost.create_notification_comment!(company, comment.id, "company") }.to change{ Notification.count }.by(1)
    end
  end
end
