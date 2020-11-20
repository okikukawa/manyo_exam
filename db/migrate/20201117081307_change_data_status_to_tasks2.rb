class ChangeDataStatusToTasks2 < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :status,:string
  end
end
