class RemoveBatonFromMembers < ActiveRecord::Migration
  def up
    remove_column :members, :baton
  end

  def down
    add_column :members, :baton, :string
  end
end
