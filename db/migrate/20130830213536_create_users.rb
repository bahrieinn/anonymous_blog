class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :salt
      t.timestamps
    end
    #add_index :table_name, :column, validation: true/false/etc.
    add_index :users, :email, unique: true
  end
end
