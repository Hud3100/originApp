class AddReferencesToImages < ActiveRecord::Migration[5.2]
  def change
    add_reference :images, :imageable, polymorphic: true, index: true
  end
end
