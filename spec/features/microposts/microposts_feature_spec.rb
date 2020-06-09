require 'rails_helper'

RSpec.feature '質問の投稿とコメント機能' do
  let(:sampleuser) { create :user }
  let(:anotheruser) { create :user }
  let(:company) { create :company }
  background do
    User.create!(name: "Sample Company", email: "samplecompany@company.com", password: "samplepassword")
  end

  scenario '質問の投稿' do
    login(sampleuser)
    visit micropost_new_path
    fill_in '件名', with: "オデッセイのカスタムについて"
    fill_in '質問内容', with: "オデッセイの乗り心地改善やマフラーを変更したいです。"
    fill_in '予算', with: "30"
    select '走り', from: 'selector_name'
    # 画像の添付
    expect( )
    click_on '投稿する'
    expect(page).to have_content "投稿が完了しました。"
  end

  scenario '質問のコメントをカンパニーが行う' do
    login_as(company)
    visit micropost_path(Micropost.first)
    fill_in '件名', with: "カスタムのご提案"
    fill_in '内容', with: "乗り心地改善に関しては、サスペンションやショックアブソーバーの交換を
    おすすめします。マフラーは当社自慢の可変バルブ付きマフラーがございます。"
    click_on 'コメントする'
    expect(page).to have_content "コメントが投稿されました。"
    # 画像の添付
  end

  scenario '質問のコメントをユーザーが行う' do
    skip
    # 画像の添付
  end

  scenario '質問をユーザーがお気に入り登録する' do
    skip
  end

  scenario '質問をユーザーがお気に入りから解除する' do
    skip
  end
end