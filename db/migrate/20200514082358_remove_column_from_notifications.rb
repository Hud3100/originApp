class RemoveColumnFromNotifications < ActiveRecord::Migration[5.2]
  def up
    remove_column :notifications, :visited_id
    remove_column :notifications, :visitor_id
  end
  def down
    add_column :notifications, :visited_id
    add_column :notifications, :visitor_id
  end
end
