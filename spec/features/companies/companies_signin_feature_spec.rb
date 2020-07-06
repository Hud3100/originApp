require 'rails_helper'

RSpec.feature 'カスタムショップのログインとログアウト' do
  let(:testcompany) { create(:company, email: "testcompany@company.com") }
  background do
    Company.create!(name: "Sample Company", email: "samplecompany@company.com", password: "samplepassword")
  end

  scenario 'ログインする' do
    visit new_company_session_path
    fill_in 'email', with: 'samplecompany@company.com'
    fill_in 'company_password', with: "samplepassword"
    find('.btn-login').click
    expect(page).to have_content 'ログインしました'
  end

  scenario 'メールアドレスを間違えるとエラーが表示される' do
    visit new_company_session_path
    fill_in 'email', with: 'anothercompany@company.com'
    fill_in 'company_password', with: "samplepassword"
    find('.btn-login').click
    expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
  end

  scenario 'パスワードを間違えるとエラーが表示される' do
    visit new_company_session_path
    fill_in 'email', with: 'samplecompany@company.com'
    fill_in 'company_password', with: "wrongpassword"
    find('.btn-login').click
    expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
  end

  scenario 'ログアウト' do
    login_as_company(testcompany)
    visit company_path(testcompany)
    click_link 'ログアウト'
    expect(page).to have_content 'ログアウトしました。'
  end
end