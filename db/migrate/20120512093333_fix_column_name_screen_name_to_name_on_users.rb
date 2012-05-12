class FixColumnNameScreenNameToNameOnUsers < ActiveRecord::Migration
  def up
    rename_column :users, :screen_name, :name
  end

  def down
    rename_column :users, :name, :screen_name
  end
end
