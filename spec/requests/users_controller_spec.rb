require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'GET #show' do
    context 'ユーザーが存在する場合' do
      let(:user) { create :user, name: 'Takashi' }
      it 'リクエストが成功すること' do
        sign_in user
        get user_url user
        expect(response.status).to eq 200
      end

      it 'ユーザー名が表示されていること' do
        get user_url user
        expect(response.body).to include 'Takashi'
      end
    end

    context 'ユーザーが存在しない場合' do
      skip
    end
  end
end