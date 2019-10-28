class RenameColumnsToTasks < ActiveRecord::Migration[5.2]
  def up
    rename_column :tasks, :task_name, :name
    rename_column :tasks, :detail, :detail
  end

  def down
    rename_column :tasks, :name, :task_name
    rename_column :tasks, :detail, :detail  
  end
end
