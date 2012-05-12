require 'spec_helper'

describe WelcomeController do

  describe "GET 'index'" do
    render_views

    describe "without login" do
      it "returns http success" do
        get 'index'
        response.should be_success
        response.body.should =~ /Log in/
      end
    end

    describe "with login" do
      before(:each) do
        @user = FactoryGirl.create(:user, provider: "twitter", uid: "3333", name: "Jack")
        session[:user_id] = @user.id
      end

      it "returns http success" do
        get 'index'
        response.should be_success
        response.body.should =~ /Log out/
      end
    end
  end

end
