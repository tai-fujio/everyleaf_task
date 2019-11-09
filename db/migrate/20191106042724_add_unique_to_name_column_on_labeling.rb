class AddUniqueToNameColumnOnLabeling < ActiveRecord::Migration[5.2]
  def change
    add_index :labelings, :name, unique: true
  end
end
