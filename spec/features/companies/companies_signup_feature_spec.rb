require 'rails_helper'

RSpec.feature 'カスタマーショップの利用登録' do
  background do
    Company.create!(name: "Sample Company", email: "samplecompany@company.com", password: "samplepassword")
  end
  scenario 'カスタマーショップの登録をする' do
    visit new_company_registration_path
    fill_in 'ショップ名', with: "Another Company"
    fill_in 'メールアドレス', with: "anothercompany@company.com"
    fill_in 'パスワード', with: "anotherpassword"
    fill_in '確認用パスワード', with: "anotherpassword"
    click_on '登録'
    expect(page).to have_content 'アカウント登録が完了しました'
  end

  scenario '入力されたパスワードが6文字未満の場合、登録に失敗し、エラーが表示される' do
    visit new_company_registration_path
    fill_in 'ショップ名', with: "Another Company"
    fill_in 'メールアドレス', with: "anothercompany@company.com"
    fill_in 'パスワード', with: "12345"
    fill_in '確認用パスワード', with: "12345"
    click_on '登録'
    expect(page).to have_content(
      '1 件のエラーが発生したため カスタマーショップ は保存されませんでした。',
      'パスワードは6文字以上で入力してください'
    )
  end

  scenario 'ショップ名が入力されなかった場合、登録に失敗し、エラーが表示される' do
    visit new_company_registration_path
    fill_in 'ショップ名', with: ""
    fill_in 'メールアドレス', with: "anothercompany@company.com"
    fill_in 'パスワード', with: "samplepassword"
    fill_in '確認用パスワード', with: "samplepassword"
    click_on '登録'
    expect(page).to have_content(
      '1 件のエラーが発生したため カスタマーショップ は保存されませんでした。',
      'ショップ名を入力してください'
    )
  end

  scenario 'メールアドレスが入力されなかった場合、登録に失敗し、エラーが表示される' do
    visit new_company_registration_path
    fill_in 'ショップ名', with: "Another Company"
    fill_in 'メールアドレス', with: ""
    fill_in 'パスワード', with: "samplepassword"
    fill_in '確認用パスワード', with: "samplepassword"
    click_on '登録'
    expect(page).to have_content(
      '1 件のエラーが発生したため カスタマーショップ は保存されませんでした。',
      'メールアドレスを入力してください'
    )
  end

  scenario '入力されたパスワードと確認用パスワードが異なる場合、登録に失敗し、エラーが表示される' do
    visit new_company_registration_path
    fill_in 'ショップ名', with: "Another Company"
    fill_in 'メールアドレス', with: "sample@sample.com"
    fill_in 'パスワード', with: "correctpassword"
    fill_in '確認用パスワード', with: "wrongpassword"
    click_on '登録'
    expect(page).to have_content(
      '1 件のエラーが発生したため カスタマーショップ は保存されませんでした。',
      '確認用パスワードとパスワードの入力が一致しません'
    )
  end

  scenario '登録済みのメールアドレスが登録される場合、登録に失敗し、エラーが表示される' do
    visit new_company_registration_path
    fill_in 'ショップ名', with: "Another Company"
    fill_in 'メールアドレス', with: "samplecompany@company.com"
    fill_in 'パスワード', with: "password"
    fill_in '確認用パスワード', with: "password"
    click_on '登録'
    expect(page).to have_content(
      '1 件のエラーが発生したため カスタマーショップ は保存されませんでした。',
      'メールアドレスはすでに存在します'
    )
  end

  scenario '登録済みの社名が登録される場合、登録に失敗し、エラーが表示される' do
    visit new_company_registration_path
    fill_in 'ショップ名', with: "Sample Company"
    fill_in 'メールアドレス', with: "anotheruser@user.com"
    fill_in 'パスワード', with: "password"
    fill_in '確認用パスワード', with: "password"
    click_on '登録'
    expect(page).to have_content(
      '1 件のエラーが発生したため カスタマーショップ は保存されませんでした。',
      'ショップ名はすでに存在します'
    )
  end
end
