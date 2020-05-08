require 'rails_helper'

RSpec.feature 'micropost' do
  let(:user) { create(:user) }
  before do
    user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
    login_as(user, :scope => :user)
    visit new_micropost_path
  end

  scenario 'タイトルと内容が入力されていなければエラーメッセージを表示する' do
    fill_in 'form-title', with: ""
    fill_in 'form-content', with: ""
    click_on '投稿する'
    expect(page).to have_content "投稿に失敗しました"
  end

  scenario '内容が入力されなければエラーメッセージを表示する' do
    fill_in 'form-title', with: "投稿のタイトル"
    fill_in 'form-content', with: ""
    click_on '投稿する'
    expect(page).to have_content "投稿に失敗しました"
  end

  scenario 'タイトルが入力されなければエラーメッセージを表示する' do
    fill_in 'form-title', with: ""
    fill_in 'form-content', with: "投稿の内容"
    click_on '投稿する'
    expect(page).to have_content "投稿に失敗しました"
  end

  scenario 'タイトルと内容を入力し、投稿する' do
    visit new_micropost_path
    fill_in 'form-title', with: "質問のタイトル"
    fill_in 'form-content', with: "質問の内容"
    click_on ('投稿する')
    #投稿に成功したことを検証する
    expect(page).to have_content "投稿されました"
  end
end