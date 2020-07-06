require 'rails_helper'
RSpec.describe MicropostCategoryRelation, type: :model do
  let(:user) { create(:user) }
  let(:micropost) { create(:micropost) }
  let(:category) { create(:category) }
  context "モデル生成:" do
    it "投稿がカテゴリーと紐づくとき、中間テーブルが生成される" do
      micropost = user.microposts.new(
        title: "Sample",
        content: "Sample Content",
        category_ids: category.id
      )
      expect { micropost.save }.to change(MicropostCategoryRelation, :count).by(1)
    end

    it "Micropost_idが無効なら中間テーブルは生成されない" do
      ref = MicropostCategoryRelation.create(
        micropost_id: nil,
        category_id: category.id
      )
      expect(ref).not_to be_valid
    end

    it "Category_idが無効なら中間テーブルは生成されない" do
      ref = MicropostCategoryRelation.create(
        micropost_id: micropost.id,
        category_id: nil
      )
      expect(ref).not_to be_valid
    end
  end

  context "アソシエーション:" do
    it "Micropostmodelに属する" do
      t = MicropostCategoryRelation.reflect_on_association(:micropost)
      expect(t.macro).to eq(:belongs_to)
      expect(t.class_name).to eq "Micropost"
    end

    it "Categorymodelに属する" do
      t = MicropostCategoryRelation.reflect_on_association(:category)
      expect(t.macro).to eq(:belongs_to)
      expect(t.class_name).to eq "Category"
    end
  end

  context "削除:" do
    it "投稿が削除された時、中間テーブルも削除される" do
      micropost = create(:micropost, category_ids: category.id)
      expect { micropost.destroy }.to change(MicropostCategoryRelation, :count).by(-1)
    end

    it "中間テーブル(関連付け)が削除されてもMicropostは削除されない" do
      ref = MicropostCategoryRelation.create(
        micropost_id: micropost.id,
        category_id: category.id
      )
      expect { ref.destroy }.not_to change(Micropost, :count)
    end
  end
end
