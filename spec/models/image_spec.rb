require 'rails_helper'
RSpec.describe Image, type: :model do
  let(:image_path) { File.join(Rails.root, 'spec/fixtures/test.jpg') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }
  let(:user) { create(:user) }
  let(:micropost) { create(:micropost) }
  context "バリデーション:" do
    it "imageモデルのみの生成は不可" do
      image = Image.create(
        img: image
      )
      expect(image).not_to be_valid
    end

    it "投稿あるいはコメントに結びついて始めて生成される" do
      expect { create(:micropost, images_attributes: [img: image]) }.to change(Image, :count).by(1)
    end

    it "画像が添付されなかったとき、Imageモデルは生成されない" do
      expect { create(:micropost) }.not_to change(Image, :count)
    end

    it "無効なファイルを渡された場合とき、Imageモデルは生成されない" do
      skip
    end
  end

  context "アソシエーション:" do
    it "ポリモーフィックをもつ" do
      t = Image.reflect_on_association(:imageable)
      expect(t.macro).to eq(:belongs_to)
      expect(t.class_name).to eq "Imageable"
    end

    it "画像を削除後、投稿あるいはコメントは削除されない" do
      skip
    end
  end
end
