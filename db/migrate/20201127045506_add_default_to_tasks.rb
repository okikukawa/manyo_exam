class AddDefaultToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :deadline, :date, default: "2020-01-01"
  end
end
