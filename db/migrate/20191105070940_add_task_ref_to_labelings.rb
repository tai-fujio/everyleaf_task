class AddTaskRefToLabelings < ActiveRecord::Migration[5.2]
  def change
    add_reference :labelings, :task, foreign_key: true
  end
end
