require 'rails_helper'
RSpec.describe Category, type: :model do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  context "バリデーション:" do
    # it "カテゴリーの数は4つである" do
    #   expect(Category.count).to eq(Constants::CATEGORY_COUNT)
    # end

    it "名前のないカテゴリーは無効" do
      category = Category.create(
        name: nil
      )
      expect(category).not_to be_valid
    end
  end

  context "アソシエーション:" do
    it "MicropostCategoryRelationsをもつ" do
      t = Category.reflect_on_association(:micropost_category_relations)
      expect(t.macro).to eq(:has_many)
      expect(t.class_name).to eq "MicropostCategoryRelation"
    end

    it "Micropostsをもつ" do
      t = Category.reflect_on_association(:microposts)
      expect(t.macro).to eq(:has_many)
      expect(t.class_name).to eq "Micropost"
    end

    it "カテゴリーに属した投稿が出来る" do
      micropost = user.microposts.create(
        title: "Sample",
        content: "sample content",
        category_ids: category.id
      )
      expect(micropost).to be_valid
    end
  end

  context "削除:" do
    it "投稿を削除してもカテゴリーは削除されない" do
      micropost = user.microposts.create(
        title: "Sample",
        content: "sample content",
        category_ids: category.id
      )
      expect { micropost.destroy }.not_to change{ Category.count }
    end
  end
end
