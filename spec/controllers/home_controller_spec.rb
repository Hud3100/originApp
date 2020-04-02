require 'rails_helper'

describe HomeController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #index' do
    before do
      visit root_path
    end

    it "レスポンスが成功する" do
      expect(response).to be_success
    end
  end
end
