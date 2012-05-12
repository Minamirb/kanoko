class ArticlesAddPicture < ActiveRecord::Migration
  def up
    add_column :articles, :picture, :binary
  end

  def down
    remove_column :articles, :picture
  end
end
