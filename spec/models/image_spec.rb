require 'rails_helper'

RSpec.describe Image, type: :model do
  let(:image_path) { File.join(Rails.root, 'spec/fixtures/test.jpg') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }
  let(:user) { create(:user) }
  let(:micropost) { create(:micropost) }
  let(:comment) { create(:comment) }
  context "バリデーション:" do
    it "関連付けなしで、Imageモデルのみの生成は不可" do
      image = Image.create(
        img: image
      )
      expect(image).not_to be_valid
    end
  end

  context "アソシエーション:" do
    it "ポリモーフィックをもつ" do
      t = Image.reflect_on_association(:imageable)
      expect(t.macro).to eq(:belongs_to)
      expect(t.class_name).to eq "Imageable"
    end
  end
end
