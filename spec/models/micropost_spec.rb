require 'rails_helper'
RSpec.describe Micropost, type: :model do
  let(:user) { create(:user) }
  let(:another_user) { create(:another_user) }
  let(:image_path) { File.join(Rails.root, 'spec/fixtures/test.jpg') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }

  context "バリデーション:" do
    it "投稿の題名、本文、外部キー(user_id)があれば有効" do
      micropost = user.microposts.create(
        title: "サンプルタイトル",
        content: "サンプルコンテンツ"
      )
      expect(micropost).to be_valid
    end

    it "投稿のタイトルがなければ無効" do
      micropost = user.microposts.create(
        title: nil,
        content: "サンプルコンテンツ"
      )
      expect(micropost).not_to be_valid
      expect(micropost.errors[:title]).to include("を入力してください")
    end

    it "投稿の内容がなければ無効" do
      micropost = user.microposts.create(
        title: "サンプルタイトル",
        content: nil
      )
      expect(micropost).not_to be_valid
      expect(micropost.errors[:content]).to include("を入力してください")
    end

    it "ユーザーの外部キー(user_id)がなければ無効" do
      micropost = Micropost.create(
        user_id: nil,
        title: "サンプルタイトル",
        content: "サンプルコンテンツ"
      )
      expect(micropost).not_to be_valid
      expect(micropost.errors[:user_id]).to include("を入力してください")
    end

    it "同一のユーザーは過去投稿の内容を有する投稿を作成できない" do
      user.microposts.create(
        title: "サンプルタイトル",
        content: "サンプルコンテント"
      )
      micropost = user.microposts.create(
        title: "サンプルタイトル",
        content: "サンプルコンテント"
      )
      expect(micropost).not_to be_valid
      expect(micropost.errors[:content]).to include("はすでに存在します")
    end

    it "異なるユーザーはそれぞれ同じ内容を有する投稿を作成できない" do
      user.microposts.create(
        title: "サンプルタイトル",
        content: "サンプルコンテンツ"
      )
      micropost = another_user.microposts.create(
        title: "サンプルタイトル",
        content: "サンプルコンテンツ"
      )
      expect(micropost).not_to be_valid
    end
  end

  context "アソシエーション:" do
    it "Userモデルに属する" do
      t = Micropost.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
      expect(t.class_name).to eq "User"
    end

    it "投稿を削除してもUserは削除されない" do
      micropost = user.microposts.create(
                    title: "Sample",
                    content: "Sample Post"
                    )
      expect { micropost.destroy }.to change{ Micropost.count }.by(-1)
      expect { micropost.destroy }.not_to change{ User.count }
    end

    it "Imageモデルをもつ" do
      t = Micropost.reflect_on_association(:images)
      expect(t.macro).to eq(:has_many)
      expect(t.class_name).to eq "Image"
    end

    it "投稿を削除すると、関連する画像が削除される" do
      micropost = user.microposts.create(
        title: "Sample",
        content: "Sample Post"
      )
      micropost.images.create(
        img: image
      )
      expect { micropost.destroy }.to change{ Image.count }.by(-1)
    end

    it "Commentモデルをもつ" do
      t = Micropost.reflect_on_association(:comments)
      expect(t.macro).to eq(:has_many)
    end

    it "投稿を削除すると関連するコメントが削除される" do
      skip
    end

    it "Favoritesモデルに属する" do
      t = Micropost.reflect_on_association(:favorites)
      expect(t.macro).to eq(:has_many)
    end

    it "投稿を削除すると関連するお気に入りが削除される" do
      skip
    end

    it "notificationモデルをもつ" do
      t = Micropost.reflect_on_association(:notifications)
      expect(t.macro).to eq(:has_many)
    end

    it "投稿を削除すると関連する通知が削除される" do
      skip
    end

    it "MicropostCategoryRelationをもつ" do
      t = Micropost.reflect_on_association(:micropost_category_relations)
      expect(t.macro).to eq(:has_many)
    end

    it "投稿を削除すると属していたカテゴリの関連付が削除される" do
      skip
    end

    it "Categoryモデルをもつ" do
      t = Micropost.reflect_on_association(:categories)
      expect(t.macro).to eq(:has_many)
    end

    it "投稿を削除しても、カテゴリは削除されない" do
      skip
    end

  end

  context "クラスメソッド: " do
    skip
  end

  context "削除:" do
    it "投稿は削除可能" do
      micropost = user.microposts.create(
        title: "Sample",
        content: "Sample Post"
        )
      expect { micropost.destroy }.to change{ Micropost.count }.by(-1)
    end
  end
end