module LoginMacros
  def login(user)
    visit new_user_session_path
    fill_in 'email', with: user.email
    fill_in 'user_password', with: "password"
    find('.btn-login').click
    expect(page).to have_content 'ログインしました。'
  end

  def logout
    click_link 'ログアウト'
    expect(page).to have_content 'ログアウトしました。'
  end

  def act_as(user)
    login user
    yield
    logout
  end

  def login_as_company(company)
    visit new_company_session_path
    fill_in 'email', with: company.email
    fill_in 'パスワード', with: "password"
    find('.btn-login').click
    expect(page).to have_content 'ログインしました'
  end

  def logout_as_company(company)
    visit company_path(company)
    click_link 'ログアウト'
    expect(page).to have_content 'ログアウトしました。'
  end

  def act_as_company(company)
    login_as_company company
    yield
    logout_as_company company
  end
end