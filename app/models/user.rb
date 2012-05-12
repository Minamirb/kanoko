class User < ActiveRecord::Base
  has_many :members
  has_many :diaries, through: :members
  attr_accessible :name

  has_many :accounts

  def self.create_with_omniauth(auth)
    create! do |user|
      attrs = {
        provider: auth['provider'],
        uid:      auth['uid'],
        name:     (auth['info']['name'] rescue ''),
        token:    (auth['credentials']['token'] rescue ''),
      }
      user.accounts.build(attrs)
      user.name = auth['info']['nickname']
    end
  end

  def self.find_by_provider_and_uid(provider, uid)
    account = Account.find_by_provider_and_uid(provider, uid)
    account.user unless account.nil?
  end
end
