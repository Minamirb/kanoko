class Member < ActiveRecord::Base
  belongs_to :user
  belongs_to :diary
  attr_accessible :user_id, :diary_id, :baton, :sort
end
