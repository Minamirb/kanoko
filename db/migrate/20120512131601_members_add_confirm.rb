class MembersAddConfirm < ActiveRecord::Migration
  def up
    add_column :members, :confirm, :boolean, :default => false
    add_column :members, :confirm_hash, :string
  end

  def down
    remove_column :members, :confirm
    remove_column :members, :confirm_hash
  end
end
