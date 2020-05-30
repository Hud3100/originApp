require 'rails_helper'

RSpec.describe Image, type: :model do
  let(:image_path) { File.join(Rails.root, 'spec/fixtures/test.jpg') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }
  let(:user) { create(:user) }
  let(:micropost) { create(:micropost) }

  context "imageモデル生成" do
    it "関連付けなしで、Imageモデルのみの生成は不可?" do
      image = Image.create(
        img: image
      )
      expect(image).not_to be_valid
    end

    it "投稿内容と同時に生成" do
      post = micropost
      expect(post).to be_valid
    end

    it "コメントと同時に生成" do
    end
  end
end
