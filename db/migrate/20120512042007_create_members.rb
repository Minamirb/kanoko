class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.references :user
      t.references :diary
      t.integer :sort
      t.integer :baton

      t.timestamps
    end
    add_index :members, :user_id
    add_index :members, :diary_id
  end
end
