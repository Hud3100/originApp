require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe 'GET #new' do
    it 'リクエストが成功すること' do
      get new_user_session_url
      expect(response.status).to eq 200
    end
  end
end
