require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:user) { create(:user) }
  let(:another_user) { create(:another_user) }

  it "投稿の題名、本文、外部キー(user_id)があれば有効" do
    micropost = user.microposts.create(
      title: "テスト",
      content: "サンプル"
    )
    expect(micropost).to be_valid
  end

  it "投稿の題名がなければ無効" do
    micropost = user.microposts.create(
      content: "サンプル"
    )
    expect(micropost).not_to be_valid
  end

  it "投稿の内容がなければ無効" do
    micropost = user.micropost.create(
      content: nil
    )
    expect(micropost).not_to be_valid
  end

  it "ユーザーが投稿できる" do
    micropost = user.microposts.create(
      title: "テスト",
      content: "サンプル"
    )
    expect(micropost).to be_valid
  end
end