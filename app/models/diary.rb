class Diary < ActiveRecord::Base
  attr_accessible :deliver, :title
  has_many :members
  has_many :users, through: :members
  has_many :articles

  def next_baton_owner
    sorted_members = members.sort { |m, n| m.sort <=> n.sort }
    i = sorted_members.index { |m| m.user_id == baton }
    (sorted_members[i+1].user rescue nil) || sorted_members.first.user
  end

  def baton_pass!
    self.baton = next_baton_owner.id
    save!
  end
end
