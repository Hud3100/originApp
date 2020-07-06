require 'rails_helper'

RSpec.describe "HomesController" do
  let(:user) { create(:user) }
  let(:company) { create(:company) }
  describe "GET #index" do
    it 'リクエスト が成功すること' do
      get root_url
      expect(response).to have_http_status(200)
    end

    it 'ホーム画面にようこそが表示される' do
      get root_url
      expect(response.body).to include "もっとカスタムを身近に"
    end

    context 'ユーザーがログインしている場合' do
      it 'ログアウトのリンクが表示される' do
        sign_in user
        get root_url
        expect(response.body).to include "ログアウト"
      end
    end

    context 'ユーザーがログアウトしている場合' do
      it 'ログインのリンクが表示される' do
        get root_url
        expect(response.body).to include "ログイン"
      end
    end

    context 'カスタムショップがログインしている場合' do
      it 'マイページのリンクが表示される' do
        sign_in company
        get root_url
        expect(response.body).to include "マイページ"
      end
    end

    context 'カスタムショップがログアウトしている場合' do
      it 'カスタムショップの方向けのリンクが表示される' do
        get root_url
        expect(response.body).to include "カスタムショップの方向け"
      end
    end
  end
end