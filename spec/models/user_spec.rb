require 'rails_helper'
RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:micropost) { create(:micropost) }
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

    it "パスワードが6文字未満であれば、ユーザーは無効" do
      user = User.create(
        name: "Test User",
        email: "test@test.com",
        password: "12345"
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

    it "同じ名前のユーザーの複数登録不可" do
      user = User.create(
        name: "Test User",
        email: "user@sample.com",
        password: "password"
      )
      another_user = User.create(
        name: "Test User",
        email: "anotheruser@sample.com",
        password: "password"
      )
      expect(another_user).not_to be_valid
      expect(another_user.errors[:name]).to include("はすでに存在します")
    end

    it "同じメールアドレスの複数ユーザーの登録は不可" do
      user = User.create(
        name: "Test User",
        email: "user@sample.com",
        password: "password"
      )
      another_user = User.create(
        name: "Another User",
        email: "user@sample.com",
        password: "password"
      )
      expect(another_user).not_to be_valid
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end
  end

  context "アソシエーション:" do
    it "Micropostモデルをもつ" do
      t = User.reflect_on_association(:microposts)
      expect(t.macro).to eq(:has_many)
      expect(t.class_name).to eq "Micropost"
    end

    it "ユーザーを削除すると,そのユーザーがもつMicropostも削除される" do
      user.microposts.create(
        title: "Sample",
        content: "Sample Text")
      expect { user.destroy }.to change{ Micropost.count }.by(-1)
    end

    it "Commentモデルをもつ" do
      t = User.reflect_on_association(:comments)
      expect(t.macro).to eq(:has_many)
      expect(t.class_name).to eq "Comment"
    end

    it "ユーザーを削除すると、ユーザーがもつCommentも削除される" do
      comment = user.comments.create(
        title: "Sample",
        content: "Sample comments",
        micropost_id: micropost.id
      )
      expect(comment).to be_valid
      expect { user.destroy }.to change{ Comment.count }.by(-1)
    end
  end

  context "削除:" do
    it "ユーザーは削除できる" do
      user = User.create(
        name: "sample",
        email: "sample@sample.com",
        password: "password"
      )
      expect { user.destroy }.to change{ User.count }.by(-1)
    end
  end
end
