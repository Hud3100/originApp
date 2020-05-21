class CreateMicropostCategoryRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :micropost_category_relations do |t|
      t.integer :micropost_id
      t.integer :category_id

      t.timestamps
    end
  end
end
