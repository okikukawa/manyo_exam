class ChangeColumnNullTask5 < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :status, false, "-"
  end
end
