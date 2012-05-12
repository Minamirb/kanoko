class Member < ActiveRecord::Base
  attr_accessible :user_id, :diary_id, :sort
  belongs_to :user
  belongs_to :diary
  has_many :articles

  def prev_member
    prev = Member.where('diary_id = ? and sort < ?', diary.id, sort).order('sort').first
    prev ||= Member.where('diary_id = ?', diary.id).order('sort').last
  end
end
