class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, limit: 30, null: false, default: "-"
      t.string :email, limit:150, null:false, default: "-", unique: true
      t.string :password_digest, limit:150, null:false, default: "password"
      t.boolean :admin?, default: false

      t.timestamps
    end
  end
end
