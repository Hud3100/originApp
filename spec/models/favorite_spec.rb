require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:user) { create(:user) }
  let(:micropost) { create(:micropost) }
  context "バリデーション:" do
    it "User_idがなければ生成できない" do
      fav = Favorite.create(
        user_id: nil,
        micropost_id: micropost.id
      )
      expect(fav).not_to be_valid
    end

    it "Micropost_idがなければ生成できない" do
      fav = Favorite.create(
        user_id: user.id,
        micropost_id: nil
      )
      expect(fav).not_to be_valid
    end
  end

  context "アソシエーション:" do
    it "Userモデルに属する" do
      t = Favorite.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
      expect(t.class_name).to eq "User"
    end

    it "ユーザーは投稿をお気に入りに登録できる" do
      fav = user.favorites.create(
        micropost_id: micropost.id
      )
      expect(fav).to be_valid
    end

    it "ユーザーが削除されるとお気に入りも削除される" do
      user.favorites.create(micropost_id: micropost.id)
      expect { user.destroy }.to change(Favorite, :count).by(-1)
    end

    it "Micropostモデルに属する" do
      t = Favorite.reflect_on_association(:micropost)
      expect(t.macro).to eq(:belongs_to)
      expect(t.class_name).to eq "Micropost"
    end

    it "投稿が削除されると、お気に入りも削除される" do
      user.favorites.create(micropost_id: micropost.id)
      expect { micropost.destroy }.to change(Favorite, :count).by(-1)
    end
  end
end
