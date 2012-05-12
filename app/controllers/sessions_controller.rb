class SessionsController < ApplicationController
  def callback
    auth = request.env["omniauth.auth"]
    # user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
    user ||= User.find_by_provider_and_name(auth["provider"], auth["name"])
    user ||= User.create_with_omniauth(auth)
    account = user.accounts.detect { |a| a.provider == auth["provider"] }
    if account
      account.secret = (auth['credentials']['secret'] rescue '')
      account.token  = (auth['credentials']['token'] rescue '')
      account.save
    end
    session[:user_id] = user.id
    if session[:url]
      url = session[:url].clone
      session.delete(:url)
      redirect_to url
    else
      redirect_to diaries_path, :notice => "Logged in"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, :notice => "Logged out"
  end
end
