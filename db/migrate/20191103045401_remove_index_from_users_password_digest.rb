class RemoveIndexFromUsersPasswordDigest < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :password_digest, :string, limit: nil
  end
end
