class ChangeColumnNullDeadlinePriorityStatusOfTasks < ActiveRecord::Migration[5.2]
  def up
    change_column_null :tasks, :deadline, false, Time.at(Time.at(0).getutc)
    change_column :tasks, :deadline, :date, default: Date.today.strftime("%Y年 %m月 %d日")
    change_column_null :tasks, :priority, false, "-"
    change_column_null :tasks, :status, false, "-"
  end
  def down
    change_column_null :tasks, :deadline, true
    change_column_null :tasks, :priority, true
    change_column_null :tasks, :status, true
  end
end
