class AddColumnsToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :task_deadline, :date  
    add_column :tasks, :task_priority, :string 
    add_column :tasks, :task_status, :string 
  end
end
