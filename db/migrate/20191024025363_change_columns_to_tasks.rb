class ChangeColumnsToTasks < ActiveRecord::Migration[5.2]
  def up
    change_column_null :tasks, :task_details, null:false
  end

  def down
    change_column_null :tasks, :task_details, null:true
  end
end
