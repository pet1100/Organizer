class CreateUser < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string "username", limit: 255
      t.string "password_digest", limit: 255
      t.boolean "admin"
      t.timestamps
    end
    add_index :users, :username
  end
end
