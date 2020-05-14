class RemoveCompanyIdToComment < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :company_id, :integer
  end
end
