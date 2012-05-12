require 'spec_helper'

describe SessionsController do

  describe "Twitter account" do
    describe "GET 'auth/twitter/callback'" do
      describe "login with new valid account" do
        before(:each) do
          request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
        end

        it "should login" do
          get 'callback', :provider => "twitter"
          response.should redirect_to(diaries_url)
        end
      end

      describe "login with existing valid account" do
        before(:each) do
          twitter_user = OmniAuth.config.mock_auth[:twitter]
          user = FactoryGirl.create(:user)
          attrs = {
            user_id:  user.id,
            provider: twitter_user["provider"],
            uid:      twitter_user["uid"],
            name:     twitter_user["info"]["name"],
          }
          account = FactoryGirl.create(:account, attrs)

          request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
        end

        it "should login" do
          get 'callback', :provider => "twitter"
          response.should redirect_to(diaries_url)
        end
      end
    end

  end
end
