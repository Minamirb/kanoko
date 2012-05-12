class Member < ActiveRecord::Base
  belongs_to :user
  belongs_to :diary
  has_many :articles
  attr_accessible :user_id, :diary_id, :baton, :sort

  def baton_pass
    diary = self.diary
    next_member = Member.where('diary_id = ? and sort > ?', diary.id, self.sort).first
    if next_member.nil?
      next_member = Member.where('diary_id = ?', diary.id).order('sort').first
    end
    next_user_id = next_member.user.id
    Member.where('diary_id = ?', diary.id).update_all(baton: next_user_id)
  end

  def prev_member
    prev = Member.where('diary_id = ? and sort < ?', diary.id, sort).order('sort').first
    prev ||= Member.where('diary_id = ?', diary.id).order('sort').last
  end
end
