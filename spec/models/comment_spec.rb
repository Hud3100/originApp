require 'rails_helper'
RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:micropost) { create(:micropost) }
  let(:company) { create(:company) }
  let(:image_path) { File.join(Rails.root, 'spec/fixtures/test.jpg') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }
  context "バリデーション: " do
    it "Comment単体でのインスタンスは生成できない" do
      comment = Comment.create(
        title: "Sample Comment",
        content: "Sample comment content"
      )
      expect(comment).not_to be_valid
    end

    it "投稿と投稿者が紐づいて始めてコメントを生成できる" do
      comment = user.comments.create(
        title: "Sample Comment",
        content: "Sample comment content",
        micropost_id: micropost.id
      )
      expect(comment).to be_valid
    end

    it "タイトルがないコメントは投稿できない" do
      comment = user.comments.create(
        title: nil,
        content: "Sample comment content",
        micropost_id: micropost.id
      )
      expect(comment).not_to be_valid
      expect(comment.errors[:title]).to include("を入力してください")
    end

    it "内容がないコメントは投稿できない" do
      comment = user.comments.create(
        title: "Sample Comment",
        content: nil,
        micropost_id: micropost.id
      )
      expect(comment).not_to be_valid
      expect(comment.errors[:content]).to include("を入力してください")
    end

    it "投稿に紐づかないコメントは投稿できない" do
      comment = user.comments.create(
        title: "Sample Comment",
        content: "Sample comment content",
        micropost_id: nil
      )
      expect(comment).not_to be_valid
    end

    it "ユーザーかカンパニーどちらかに紐づかなければコメントは投稿できない" do
      comment = Comment.create(
        title: "Sample Comment",
        content: "Sample comment content",
        micropost_id: micropost.id
      )
      expect(comment).not_to be_valid
    end
  end

  context "アソシエーション" do
    it "ポリモーフィックをもつ" do
      t = Comment.reflect_on_association(:commentable)
      expect(t.macro).to eq(:belongs_to)
      expect(t.class_name).to eq "Commentable"
    end

    it "ユーザーはコメントを投稿できる" do
      comment = user.comments.create(
        title: "Sample comment",
        content: "Sample comment content",
        micropost_id: micropost.id
      )
      expect(comment).to be_valid
    end

    it "カンパニーはコメントを投稿できる" do
      comment = company.comments.create(
        title: "Sample comment",
        content: "Sample comment content",
        micropost_id: micropost.id
      )
      expect(comment).to be_valid
    end

    it "Imageモデルをもつ" do
      t = Comment.reflect_on_association(:images)
      expect(t.macro).to eq(:has_many)
      expect(t.class_name).to eq "Image"
    end

    it "画像を添付してコメントを投稿できる" do
      comment = user.comments.create(
        title: "Sample Comment",
        content: "Sample Comment Content",
        micropost_id: micropost.id,
        images_attributes: [img: image]
      )
      expect(comment).to be_valid
    end

    it "画像を添付してコメントを投稿できる" do
      comment = user.comments.create(
        title: "Sample Comment",
        content: "Sample Comment Content",
        micropost_id: micropost.id,
        images_attributes: [img: image]
      )
      expect(comment).to be_valid
    end

    it "コメントを削除すると添付された画像も削除される" do
      comment = user.comments.create(
        title: "Sample Comment",
        content: "Sample Comment Content",
        micropost_id: micropost.id,
        images_attributes: [img: image]
      )
      expect { comment.destroy }.to change{ Image.count }.by(-1)
    end
  end

  context "削除:" do
    it "コメントは削除できる" do
      comment = user.comments.create(
        title: "Sample Comment",
        content: "Sample Comment Content",
        micropost_id: micropost.id
      )
      expect { comment.destroy }.to change{ Comment.count }.by(-1)
    end
  end
end
