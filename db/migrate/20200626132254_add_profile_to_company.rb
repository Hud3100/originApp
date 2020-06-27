class AddProfileToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :profile, :text
  end
end
