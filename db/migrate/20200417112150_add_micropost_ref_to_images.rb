class AddMicropostRefToImages < ActiveRecord::Migration[5.2]
  def change
    add_reference :images, :micropost, foreign_key: true
  end
end
