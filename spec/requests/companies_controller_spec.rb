require 'rails_helper'

RSpec.describe "CompaniesController", type: :request do
  describe 'GET #show' do
    context 'カンパニーが存在する場合' do
      let(:company) { create :company, name: 'Spoon' }
      it 'リクエストが成功すること' do
        sign_in company
        get company_url company
        expect(response.status).to eq 200
      end

      it 'カスタマーショップ名が表示されていること' do
        get company_url company
        expect(response.body).to include 'Spoon'
      end
    end

    context 'カンパニーが存在しない場合' do
      subject { -> { get company_url 1 } }

      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end
end
