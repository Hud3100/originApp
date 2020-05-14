class AddRefencesToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_reference :notifications, :visitorable, polymorphic: true, index: true
    add_reference :notifications, :visitedable, polymorphic: true, index: true
  end
end
