require 'rails_helper'

describe HomeController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET home' do
    before do
      visit root_path
    end

    context "ログインしている場合、マイページへのリンク及び"

    it "リクエストが成功する" do
      expect(response.status).to eq(200)
    end

    it "Show Viewがレンダリングされている" do
      expect(response).to render_template :index
    end
  end
end
