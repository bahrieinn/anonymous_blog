class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name, presence: true, unique: true
    end
  end
end
