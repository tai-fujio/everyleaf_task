class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, limit: 30 , null: false
      t.string :email, limit: 150 ,null:false, unique: true
      t.string :password_digest
      t.boolean :admin?

      t.timestamps
    end
  end
end
