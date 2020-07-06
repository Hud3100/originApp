require 'rails_helper'

RSpec.describe "FavoritesController", type: :request do
  let(:user) { create(:user) }
  let(:micropost) { create(:micropost) }
  # let(:favorite) { Favorite.create(user_id: user.id, micropost_id: micropost.id) }
  let(:favorite) { create(:favorite, user_id: user.id, micropost_id: micropost.id) }
  before do
    sign_in user
  end

  describe "POST #create" do
    context 'パラメータが有効な場合' do
      it 'リクエストが成功すること' do
        post micropost_favorites_url(micropost.id), params: { favorite: FactoryBot.attributes_for(:favorite) }
        expect(response.status).to eq 302
      end

      it 'お気に入りが登録されること' do
        expect do
          post micropost_favorites_url(micropost.id), params: { favorite: FactoryBot.attributes_for(:favorite) }
        end.to change(Favorite, :count).by(1)
      end

      it 'お気に入り解除ボタンに変更すること' do
        post micropost_favorites_url(micropost.id), params: { favorite: FactoryBot.attributes_for(:favorite) }
        expect(response).to redirect_to micropost
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post micropost_favorites_url(micropost.id), params: { favorite: FactoryBot.attributes_for(:favorite, :invalid_favorite) }
        expect(response.status).to eq 302
      end

      it 'お気に入りが登録されないこと' do
        expect do
          post micropost_favorites_url(micropost.id), params: { favorite: FactoryBot.attributes_for(:favorite, :invalid_favorite) }
        end.to change(Favorite, :count).by(1)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:another_favorite) { create(:favorite, user_id: user.id, micropost_id: micropost.id) }
    it 'リクエストが成功すること' do
      delete micropost_favorites_url(micropost.id)
      expect(response.status).to eq 302
    end

    it 'お気に入りが解除されること' do
      expect do
        delete micropost_favorites_path(micropost.id)
      end.to change(Favorite, :count).by(-1)
    end
  end
end
