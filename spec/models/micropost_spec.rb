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

    it "Imageモデルをもつ" do
      t = Micropost.reflect_on_association(:images)
      expect(t.macro).to eq(:has_many)
      expect(t.class_name).to eq "Image"
    end
  end
end