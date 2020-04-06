class AddColumnMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :budget, :integer
    add_column :microposts, :car_name, :string
  end
end
