class Account < ActiveRecord::Base
  attr_accessible :name, :provider, :screen_name, :uid, :token

  belongs_to :user
end
