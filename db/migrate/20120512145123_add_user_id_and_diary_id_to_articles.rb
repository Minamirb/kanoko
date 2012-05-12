class AddUserIdAndDiaryIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :user_id, :integer
    add_column :articles, :diary_id, :integer
  end
end
