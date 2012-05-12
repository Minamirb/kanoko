class Article < ActiveRecord::Base
  belongs_to :member
  attr_accessible :content, :picture
end
