require 'spec_helper'

describe WelcomeController do

  describe "GET 'index'" do
    render_views

    describe "without login" do
      it "returns http success" do
        get 'index'
        response.should be_success
        # response.body.should =~ /login/
        response.body.should =~ %r{/auth/twitter}
      end
    end

    describe "with login" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        @account = FactoryGirl.create(:account, user_id: @user.id, provider: "twitter", uid: "3333", name: "Jack")
        session[:user_id] = @user.id
      end

      it "returns http success" do
        get 'index'
        response.should be_success
        # response.body.should_not =~ /login/
        response.body.should_not =~ %r{/auth/twitter}
      end
    end
  end

end
