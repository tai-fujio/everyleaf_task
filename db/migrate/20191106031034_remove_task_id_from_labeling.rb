class RemoveTaskIdFromLabeling < ActiveRecord::Migration[5.2]
  def change
    remove_column :labelings, :task_id, :index
  end
end
