class Diary < ActiveRecord::Base
  has_many :members
  has_many :users, through: :members
  attr_accessible :deliver, :title
end
