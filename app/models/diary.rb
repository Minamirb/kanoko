class Diary < ActiveRecord::Base
  has_many :members
  attr_accessible :deliver, :title
end
