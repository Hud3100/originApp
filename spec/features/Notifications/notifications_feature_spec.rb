require 'rails_helper'

RSpec.feature '通知機能' do
  given(:testuser) { create :user }
  given(:anotheruser) { create :user }
  given(:anotheruser3) { create :user }
  given(:company) { create :company }
  given(:testpost) { create :micropost, user_id: testuser.id}

  context 'コメントとお気に入りの通知' do
    scenario '他ユーザーがユーザー1の質問にコメントすると通知する' do
      act_as(anotheruser) do
        visit micropost_path(testpost)
        fill_in 'タイトル', with: 'これいいですね!'
        fill_in 'コメント内容', with: 'そのカスタム僕もやってみたい!'
        expect { click_on 'コメントする' }.to change { Notification.count }.by(1)
        expect(Notification.first.visitorable_user.name).to eq anotheruser.name
        expect(Notification.first.visitedable_user.name).to eq testuser.name
        expect(Notification.first.action).to eq "comment"
      end
    end

    scenario 'カスタマーショップがユーザー1の質問にコメントする' do
      act_as_company(company) do
        visit micropost_path(testpost)
        fill_in 'タイトル', with: "こちらのカスタムはいかがでしょうか!"
        fill_in 'コメント内容', with: "エギゾーストのカスタムは当社自慢のオーダーメイドのマフラーがいいですよ!"
        expect { click_on 'コメントする' }.to change { Notification.count }.by(1)
        expect(Notification.first.visitorable_company.name).to eq company.name
        expect(Notification.first.visitedable_user.name).to eq testuser.name
        expect(Notification.first.action).to eq "comment"
      end
    end
  end
end
