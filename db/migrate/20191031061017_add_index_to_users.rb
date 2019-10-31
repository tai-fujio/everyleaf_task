class AddIndexToUsers < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :admin?, :boolean, default: false
    change_column_null :users, :admin?, null:false
  end

  def down
    change_column_null :users, :admin?, null:true
  end
end
