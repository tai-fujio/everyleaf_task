class AddColumnsToTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name ,null: false ,default: "-"
      t.string :detail,null: false ,default: "-"
      t.date :deadline,null: false ,default: -> { 'NOW()' }
      t.string :status,null: false ,default: "-"
      t.string :priority,null: false ,default: "-"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
