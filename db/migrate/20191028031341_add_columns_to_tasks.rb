class AddColumnsToTasks < ActiveRecord::Migration[5.2]
  def up
    add_column :tasks, :deadline, :date
    add_column :tasks, :priority, :string
    add_column :tasks, :status, :string
  end

  def down
    remove_column :tasks, :deadline, :update
    remove_column :tasks, :priority, :string
    remove_column :tasks, :status, :string
  end
end
