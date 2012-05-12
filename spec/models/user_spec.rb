require 'spec_helper'

describe User do
  context "No existing users" do
    describe "user finder" do
      it "should not find an user" do
        user = User.find_by_provider_and_uid("twitter", "1111")
        user.should be_nil
      end
    end

    describe "user creation" do
      it "should create new user with a Twitter account" do
        auth = {
          'provider'   => 'twitter',
          'uid'        => '1111',
          'info'       => {
            'name'     => 'Dummy',
            'nickname' => 'Dummy Nickname',
          }
        }
        user = User.create_with_omniauth(auth)
        user.should be_an_instance_of(User)
        user.should have(1).accounts
        user.accounts.first.provider.should == 'twitter'
        user.accounts.first.uid.should == '1111'
      end
    end
  end

  context "An existing user" do
    before(:each) do
      user = FactoryGirl.create(:user, name: 'Dummy Nickname')
      account = FactoryGirl.create(:account, user_id: user.id, provider: 'twitter', uid: '1111')
    end

    describe "user finder" do
      it "should find an user" do
        user = User.find_by_provider_and_uid("twitter", "1111")
        user.should be_an_instance_of(User)
      end
    end

    # describe "user creation" do
    #   it "should create new user with a Twitter account" do
    #     auth = {
    #       'provider'   => 'twitter',
    #       'uid'        => '1111',
    #       'info'       => {
    #         'name'     => 'Dummy',
    #         'nickname' => 'Dummy Nickname',
    #       }
    #     }
    #     user = User.create_with_omniauth(auth)
    #     user.should be_an_instance_of(User)
    #     user.should have(1).accounts
    #     user.accounts.first.provider.should == 'twitter'
    #     user.accounts.first.uid.should == '1111'
    #   end
    # end
  end
end
