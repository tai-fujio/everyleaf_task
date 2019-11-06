class ChangeNameColumnOnLabeling < ActiveRecord::Migration[5.2]
  def change
    change_column_null :labelings, :name, false, "-"
    change_column :labelings, :name, :string, default: "-"
  end
end
