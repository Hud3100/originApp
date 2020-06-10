require 'rails_helper'

RSpec.feature '質問の投稿とコメント機能' do
  let(:testuser) { create:user,
                   name: "Test User",
                   email: "testuser@user.com",
                  password: "sampleuser",
                  password_confirmation: "sampleuser"}
  let(:anotheruser) { create :user }
  let(:company) { create :company }
  background do
    # User.create(name: "Sample User", email: "samplecompany@company.com", password: "samplepassword")
    # Company.create!(name: "Sample Company", email: "samplecompany@company.com", password: "samplepassword")
  end

  scenario '質問の投稿' do
    login(testuser)
    visit new_micropost_path
    fill_in 'form-title', with: "オデッセイのカスタムについて"
    fill_in 'form-content', with: "オデッセイの乗り心地改善やマフラーを変更したいです。"
    fill_in '予算', with: "30"
    fill_in 'form-search-car-name', with: "オデッセイ"
    check '内装'
    attach_file "micropost[images_attributes][1][img]", "spec/fixtures/test.jpg"
    expect { click_on '投稿する' }.to change { Micropost.count }.by(1)
    expect(page).to have_content "投稿されました"
  end

  # scenario '質問のコメントをカンパニーが行う' do
  #   login_as(company)
  #   visit micropost_path(Micropost.first)
  #   fill_in '件名', with: "カスタムのご提案"
  #   fill_in '内容', with: "乗り心地改善に関しては、サスペンションやショックアブソーバーの交換を
  #   おすすめします。マフラーは当社自慢の可変バルブ付きマフラーがございます。"
  #   click_on 'コメントする'
  #   expect(page).to have_content "コメントが投稿されました。"
  #   # 画像の添付
  # end

  # scenario 'コメントorタイトルの内容が入力されていなければ弾く'

  # scenario '質問のコメントをユーザーが行う' do
  #   skip
  #   # 画像の添付
  # end

  # scenario '質問をユーザーがお気に入り登録する' do
  #   skip
  # end

  # scenario '質問をユーザーがお気に入りから解除する' do
  #   skip
  # end
end