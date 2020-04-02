require 'rails_helper'
RSpec.feature 'User', type: :feature do
  before do
    @user = create(:user)
  end

  scenario 'マイページに移動すると名前とアドレスが表示される' do
    visit user_path(id: @user.id)
    expect(page).to have_content(@user.name)
    expect(page).to have_content(@user.email)
  end
end
