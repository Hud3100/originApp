require 'rails_helper'

describe 'Suggest Controller', type: :request do
  describe "GET #suggest" do
    before do
      get '/suggest', params: { keyword: "カム" }
      @result = JSON.parse(response.body)
    end

    it 'リクエストが成功し、車名のリストを取得する' do
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    it '車名のリストを取得する' do
      expect(@result).to eq ["カムリ"]
    end
  end
end