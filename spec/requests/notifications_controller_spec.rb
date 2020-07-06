require 'rails_helper'

RSpec.describe "NotificationsController", type: :request do
  let(:user) { create(:user) }
  before do
    sign_in user
  end

  describe "GET #index" do
    it 'リクエストが成功すること' do
      get notifications_url
      expect(response.status).to eq 200
    end

    it '通知状態が表示されていること' do
      get notifications_url
      expect(response.body).to include "通知はありません"
    end
  end
end
