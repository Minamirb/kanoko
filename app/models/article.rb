class Article < ActiveRecord::Base
  attr_accessible :content, :picture
  belongs_to :user
  belongs_to :diary
  belongs_to :member

  def prev
    Article.where("created_at < ? AND diary_id = ?", created_at, diary_id).order("created_at DESC").first
  end
end
