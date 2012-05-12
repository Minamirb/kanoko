class Diary < ActiveRecord::Base
  attr_accessible :deliver, :title
  has_many :members
  has_many :users, through: :members
  has_many :articles
end
