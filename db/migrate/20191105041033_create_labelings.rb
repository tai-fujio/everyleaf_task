class CreateLabelings < ActiveRecord::Migration[5.2]
  def change
    create_table :labelings do |t|
      t.string :name ,limit: 10 ,unique: true

      t.timestamps
    end
  end
end
