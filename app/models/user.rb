class User < ActiveRecord::Base
  has_many :members
  has_many :diaries, through: :members
  attr_accessible :name, :provider, :screen_name, :uid

  has_many :accounts

  def self.create_with_omniauth(auth)
    create! do |user|
      attrs = {
        provider: auth['provider'],
        uid:      auth['uid'],
        name:     auth['info']['name'],
      }
      user.accounts.build(attrs)
      user.screen_name = auth['info']['nickname']
    end
  end

  def self.find_by_provider_and_uid(provider, uid)
    account = Account.find_by_provider_and_uid(provider, uid)
    account.user unless account.nil?
  end
end
