require 'spec_helper'

describe SessionsController do

  describe "GET 'auth/twitter/callback'" do
    describe "login with valid account" do
      before(:each) do
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
      end

      it "should login" do
        get 'callback', :provider => "twitter"
        response.should redirect_to(root_url)
      end
    end
  end

end
