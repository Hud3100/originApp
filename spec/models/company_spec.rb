require 'rails_helper'
RSpec.describe Company, type: :model do
  context "バリデーション: " do
    it "企業名およびメールアドレスを有するカンパニーは有効" do
      company = Company.new(
        email: "samplecompany@company.com",
        name: "Sample Company",
        password: "password"
      )
      expect(company).to be_valid
    end

    it "パスワードがないカンパニーは無効" do
    end

    it "企業名がないカンパニーは無効" do
    end

    it "メールアドレスがないカンパニーは無効" do
    end
  end
end
