class Account < ActiveRecord::Base
  attr_accessible :name, :provider, :screen_name, :uid

  belongs_to :user

  # def self.create_with_omniauth(auth)
  #   create! do |account|
  #     account.provider = auth['provider']
  #     account.uid = auth['uid']
  #     account.name = auth['info']['name']
  #     account.screen_name = auth['info']['nickname']
  #   end
  # end
end
