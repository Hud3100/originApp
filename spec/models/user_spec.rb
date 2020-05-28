require 'rails_helper'

RSpec.describe User, type: :model do
  context "バリデーション: " do
    it "氏名およびメールアドレスを有するユーザーは有効" do
      user = User.create(
        name: "Test User",
        email: "test@test.com",
        password: "password"
      )
      expect(user).to be_valid
    end

    it "パスワードがなければユーザーは無効" do
      user = User.create(
        name: "Test User",
        email: "test@test.com",
        password: nil
      )
      expect(user).not_to be_valid
    end

    it "氏名がなければユーザーは無効" do
      user = User.create(
        name: nil,
        email: "test@test.com",
        password: "password"
      )
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("を入力してください")
    end

    it "メールアドレスがなければユーザーは無効" do
      user = User.create(
        name: "Test User",
        email: nil
      )
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("を入力してください")
    end
  end
end
