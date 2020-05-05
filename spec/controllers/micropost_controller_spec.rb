require 'rails_helper'

describe MicropostsController, type: :controller do
  let(:user) { create(:user) }
  before do
    login user
  end

  it '投稿する' do
    #投稿内容入力画面にいく
    visit new_micropost_path
    #投稿内容を入力する
    #投稿ボタンをクリックする
    #投稿に成功したことを検証する
  end
end