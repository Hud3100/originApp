require 'rails_helper'
RSpec.describe Company, type: :model do
  let(:company) { create(:company) }
  let(:micropost) { create(:micropost) }
  context "バリデーション: " do
    it "企業名、メールアドレス、パスワードを有するカンパニーは有効" do
      company = Company.new(
        email: "samplecompany@company.com",
        name: "Sample Company",
        password: "password"
      )
      expect(company).to be_valid
    end

    it "パスワードがないカンパニーは無効" do
      company = Company.new(
        email: "samplecompany@company.com",
        email: "samplecompany@company.com",
        name: "Sample Company",
      )
      expect(company).not_to be_valid
    end

    it "企業名がないカンパニーは無効" do
      company = Company.new(
        email: "samplecompany@company.com",
        password: "password"
      )
      expect(company).not_to be_valid
    end

    it "メールアドレスがないカンパニーは無効" do
      company = Company.new(
        name: "Sample Company",
        password: "password"
      )
      expect(company).not_to be_valid
    end

    it "同じ企業名のカンパニーの複数登録不可" do
      company = Company.create(
        name: "Sample Company",
        email: "company@company.com",
        password: "password"
      )
      another_company = Company.create(
        name: "Sample Company",
        email: "another_company@company.com",
        password: "password"
      )
      expect(another_company).not_to be_valid
      expect(another_company.errors[:name]).to include("はすでに存在します")
    end

    it "同じメールアドレスのカンパニーの複数登録は不可" do
      company = Company.create(
        name: "Sample Company",
        email: "company@company.com",
        password: "password"
      )
      another_company = Company.create(
        name: "Another Company",
        email: "company@company.com",
        password: "password"
      )
      expect(another_company).not_to be_valid
      expect(another_company.errors[:email]).to include("はすでに存在します")
    end
  end

  context "アソシエーション:" do
    it "Commentモデルをもつ" do
      t = Company.reflect_on_association(:comments)
      expect(t.macro).to eq(:has_many)
      expect(t.class_name).to eq "Comment"
    end

    it "カンパニーを削除すると、カンパニーがもつCommentも削除される" do
      comment = company.comments.create(
        title: "Sample",
        content: "Company comments",
        micropost_id: micropost.id
      )
      expect(comment).to be_valid
      expect { company.destroy }.to change{ Comment.count }.by(-1)
    end
  end

  context "削除:" do
    it "カンパニーは削除できる" do
      company = Company.create(
        name: "Sample company",
        email: "samplecompany@company.com",
        password: "password"
      )
      expect { company.destroy }.to change{ Company.count }.by(-1)
    end
  end
end
