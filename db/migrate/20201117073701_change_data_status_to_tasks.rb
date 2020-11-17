class ChangeDataStatusToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :status, 'integer USING CAST(status AS integer)'
  end
end
