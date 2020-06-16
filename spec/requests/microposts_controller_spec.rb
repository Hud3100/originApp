require 'rails_helper'

RSpec.describe "MicropostsController", type: :request do
  let(:user) { create(:user) }
  let(:micropost) { create(:micropost, user_id: user.id) }
  let!(:micropost) { create(:micropost, title: "S2000をカスタムしたいな") }
  before do
    sign_in user
  end
  describe "GET #index" do
    it 'リクエストが成功すること' do
      get microposts_url
      expect(response.status).to eq 200
    end

    it '質問の一覧表示に成功する' do
      get microposts_url
      expect(response.body).to include "S2000をカスタムしたいな"
    end
  end

  describe "GET #show" do
    it 'リクエストが成功すること' do
      get microposts_url micropost
      expect(response.status).to eq 200
    end

    it '質問内容が表示されていること' do
      get microposts_url micropost
      expect(response.body).to include "S2000をカスタムしたいな"
    end

    context '投稿が存在しない場合' do
      subject { -> { get micropost_url 1 } }

      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe "GET #new" do
    it 'リクエストが成功すること' do
      get new_micropost_url
      expect(response.status).to eq 200
    end
  end

  describe 'POST #create' do
    context 'パラメータが有効な場合' do
      it 'リクエストが成功すること' do
        sign_in user
        post microposts_url, params: { micropost: FactoryBot.attributes_for(:micropost, content: "S2000にハードトップつけたい") }
        expect(response.status).to eq 302
      end

      it '質問の投稿に成功すること' do
        expect do
          post microposts_url, params: { micropost: FactoryBot.attributes_for(:micropost, content: "改造したいぞ") }
        end.to change(Micropost, :count).by(1)
      end

      it '成功後、リダイレクトする' do
        post microposts_url, params: { micropost: FactoryBot.attributes_for(:micropost, content: "改造したいぞ") }
        expect(response).to redirect_to Micropost.last
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post microposts_url, params: { micropost: FactoryBot.attributes_for(:micropost, :title_invalid) }
        expect(response.status).to eq 200
      end

      it '質問の投稿に失敗すること' do
        expect { post microposts_url, params: { micropost: FactoryBot.attributes_for(:micropost, :title_invalid) } }.to_not change(Micropost, :count)
      end

      it 'エラーが表示されること' do
        post microposts_url, params: { micropost: FactoryBot.attributes_for(:micropost, :title_invalid) }
        expect(response.body).to include 'タイトルを入力してください'
      end
    end
  end
end