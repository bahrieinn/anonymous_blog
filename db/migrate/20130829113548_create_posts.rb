class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :user
      t.string :title, :presence => true
      t.text :body, :presence => true
      t.string :author
      t.timestamps 
    end
  end
end
