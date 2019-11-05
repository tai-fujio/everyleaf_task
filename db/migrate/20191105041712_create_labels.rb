class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels do |t|
      t.integer :labeling_id
      t.integer :task_id

      t.timestamps
    end
  end
end
