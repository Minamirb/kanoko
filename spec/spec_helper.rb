# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
end

OmniAuth.config.test_mode = true
omniauth_options = {
  "provider"    => "twitter",
  "uid"         => "3333",
  "info"        => {
    'name'      => "Pumpkin King",
    'nickname'  => "Jack",
    'urls'      => { :Twitter => "localhost:3000/#twitter" },
  },
  "credentials" => { 'token' => "fafiafea988f3jr38r93u9r" },
}
OmniAuth.config.add_mock(:twitter, omniauth_options)

def create_default_twitter_user
  twitter_user = OmniAuth.config.mock_auth[:twitter]
  user = FactoryGirl.create(:user)
  attrs = {
    user_id:  user.id,
    provider: twitter_user["provider"],
    uid:      twitter_user["uid"],
    name:     twitter_user["info"]["name"],
  }
  account = FactoryGirl.create(:account, attrs)
  user
end
