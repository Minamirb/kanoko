class DevelopmentController < ApplicationController
  # Create new user and login:
  #   http://localhost:3000/development/login
  # Login by name:
  #   http://localhost:3000/development/login?name=[name]
  # Create new user with parameters:
  #   http://localhost:3000/development/login?name=[name]&uid=[uid]&provider=[provider]
  def login
    unless ["development", "test"].include?(Rails.env)
      redirect_to root_url
      return
    end

    if params[:name]
      user = User.find_by_name(params[:name])
    end

    unless user
      number = User.count + 1
      user = FactoryGirl.create(:user, name: "user%04d" % number)
      attrs = {
        user_id:  user.id,
        provider: params[:provider] || 'development',
        uid:      params[:uid]      || "%04d" % number,
        name:     params[:name]     || "dev%04d" % number,
      }
      account = FactoryGirl.create(:account, attrs)
    end

    session[:user_id] = user.id
    redirect_to root_url
  end
end
