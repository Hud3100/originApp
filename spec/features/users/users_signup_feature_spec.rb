require 'rails_helper'

RSpec.feature 'ユーザーの登録' do
  background do
    User.create!(name: "Sample User", email: "sampleuser@user.com", password: "samplepassword")
  end
  scenario 'ユーザーの登録をする' do
    visit new_user_registration_path
    fill_in '氏名', with: "Another User"
    fill_in 'メールアドレス', with: "sample@sample.com"
    fill_in 'パスワード', with: "samplepassword"
    fill_in '確認用パスワード', with: "samplepassword"
    click_on '登録'
    expect(page).to have_content 'アカウント登録が完了しました'
  end

  scenario '入力されたパスワードが6文字未満の場合、登録に失敗し、エラーが表示される' do
    visit new_user_registration_path
    fill_in '氏名', with: "Another User"
    fill_in 'メールアドレス', with: "sample@sample.com"
    fill_in 'パスワード', with: "12345"
    fill_in '確認用パスワード', with: "12345"
    click_on '登録'
    expect(page).to have_content(
      '1 件のエラーが発生したため ユーザー は保存されませんでした。',
      'パスワードは6文字以上で入力してください'
      )
  end

  scenario 'ユーザー名が入力されなかった場合、登録に失敗し、エラーが表示される' do
    visit new_user_registration_path
    fill_in '氏名', with: ""
    fill_in 'メールアドレス', with: "sample@sample.com"
    fill_in 'パスワード', with: "samplepassword"
    fill_in '確認用パスワード', with: "samplepassword"
    click_on '登録'
    expect(page).to have_content(
      '1 件のエラーが発生したため ユーザー は保存されませんでした。',
      '氏名を入力してください'
      )
  end

  scenario 'メールアドレスが入力されなかった場合、登録に失敗し、エラーが表示される' do
    visit new_user_registration_path
    fill_in '氏名', with: "Another User"
    fill_in 'メールアドレス', with: ""
    fill_in 'パスワード', with: "sample password"
    fill_in '確認用パスワード', with: "sample password"
    click_on '登録'
    expect(page).to have_content(
      '1 件のエラーが発生したため ユーザー は保存されませんでした。',
      'メールアドレスを入力してください'
      )
  end

  scenario '入力されたパスワードと確認用パスワードが異なる場合、登録に失敗し、エラーが表示される' do
    visit new_user_registration_path
    fill_in '氏名', with: "Another User"
    fill_in 'メールアドレス', with: "sample@sample.com"
    fill_in 'パスワード', with: "correctpassword"
    fill_in '確認用パスワード', with: "wrongpassword"
    click_on '登録'
    expect(page).to have_content(
      '1 件のエラーが発生したため ユーザー は保存されませんでした。',
      '確認用パスワードとパスワードの入力が一致しません'
      )
  end

  scenario '登録済みのメールアドレスが登録される場合、登録に失敗し、エラーが表示される' do
    visit new_user_registration_path
    fill_in '氏名', with: "Another User"
    fill_in 'メールアドレス', with: "sampleuser@user.com"
    fill_in 'パスワード', with: "password"
    fill_in '確認用パスワード', with: "password"
    click_on '登録'
    expect(page).to have_content(
      '1 件のエラーが発生したため ユーザー は保存されませんでした。',
      'メールアドレスはすでに存在します'
      )
  end

  scenario '登録済みの氏名が登録される場合、登録に失敗し、エラーが表示される' do
    visit new_user_registration_path
    fill_in '氏名', with: "Sample User"
    fill_in 'メールアドレス', with: "anotheruser@user.com"
    fill_in 'パスワード', with: "password"
    fill_in '確認用パスワード', with: "password"
    click_on '登録'
    expect(page).to have_content(
      '1 件のエラーが発生したため ユーザー は保存されませんでした。',
      '氏名はすでに存在します'
      )
  end
end