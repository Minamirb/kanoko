class Article < ActiveRecord::Base
  attr_accessible :content, :picture
  belongs_to :user
  belongs_to :diary
  belongs_to :member
end
