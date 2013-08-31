class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :pw_hash
      t.string :salt
      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
