class RenameAdminColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :admin?, :admin_or_not
  end
end
