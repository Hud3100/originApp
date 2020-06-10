module LoginMacros
  def login(user)
    visit new_user_session_path
    fill_in 'email', with: user.email
    fill_in 'user_password', with: "sampleuser"
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
end