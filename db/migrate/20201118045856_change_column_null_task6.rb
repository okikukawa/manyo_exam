class ChangeColumnNullTask6 < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :priority, false
  end
end
