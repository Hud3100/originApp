require 'rails_helper'

RSpec.feature 'ログインとログアウト' do
  let(:user) { create(:user) }
  background do
    User.create!(name: "Sample User", email: 'sample@sample.com', password: 'samplepass')
  end

  scenario 'ログインする' do
    visit new_user_session_path
    fill_in 'email', with: 'sample@sample.com'
    fill_in 'user_password', with: "samplepass"
    find('.btn-login').click
    expect(page).to have_content 'ログインしました'
  end

  scenario 'メールアドレスを間違えるとエラーが表示される' do
    visit new_user_session_path
    fill_in 'email', with: 'another@another.com'
    fill_in 'user_password', with: "samplepass"
    find('.btn-login').click
    expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
  end

  scenario 'パスワードを間違えるとエラー表示される' do
    visit new_user_session_path
    fill_in 'email', with: 'sample@sample.com'
    fill_in 'user_password', with: "anotherpass"
    find('.btn-login').click
    expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
  end

  scenario 'ログアウト' do
    login(user)
    visit root_path
    click_link 'ログアウト'
    expect(page).to have_content 'ログアウトしました。'
  end
end
