class RemoveColumnFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :name
    remove_column :users, :provider
    remove_column :users, :uid
  end

  def down
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :name, :string
  end
end
