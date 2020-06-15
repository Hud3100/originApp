require 'rails_helper'

RSpec.describe "Company_SessionsController", type: :request do
  describe 'GET #new' do
    it 'リクエストが成功すること' do
      get new_company_session_url
      expect(response.status).to eq 200
    end
  end
end
