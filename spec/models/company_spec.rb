require 'rails_helper'
RSpec.describe Company, type: :model do
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
  end
end
