require 'rails_helper'

RSpec.feature 'カンパニーのログインとログアウト' do
  let(:user) { create(:user) }
  background do
    Company.create!(name: "Sample Company", email: "samplecompany@company.com", password: "samplepassword")
  end

  scenario 'ログインする' do
    visit new_company_session_path
    fill_in 'Email', with: 'samplecompany@company.com'
    fill_in 'company_password', with: "samplepassword"
    find('.btn-login').click
    expect(page).to have_content 'ログインしました'
  end

  scenario 'メールアドレスを間違えるとエラーが表示される' do
    visit new_company_session_path
    fill_in 'Email', with: 'anothercompany@company.com'
    fill_in 'company_password', with: "samplepassword"
    find('.btn-login').click
    expect(page).to have_content 'Emailまたはパスワードが違います。'
  end

  scenario 'パスワードを間違えるとエラーが表示される' do
    visit new_company_session_path
    fill_in 'Email', with: 'samplecompany@company.com'
    fill_in 'company_password', with: "wrongpassword"
    find('.btn-login').click
    expect(page).to have_content 'Emailまたはパスワードが違います。'
  end

  scenario 'ログアウト' do
    skip
  end
end