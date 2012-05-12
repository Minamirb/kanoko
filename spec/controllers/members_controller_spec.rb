require 'spec_helper'

describe MembersController do
  before do
    @user = create(:user)
    @diary = @user.diaries.first
    session[:user_id] = @user.id
  end

  def valid_params
    {diary_id: @diary.to_param, member: {account_name: "yalab", provider: "twitter"}}
  end

  describe "invite not a user" do
    subject { expect { post :create, valid_params }.to }
    it "create @diary.members" do
      change(@diary.members, :count).by(1)
    end

    it "create Account" do
      change(Account, :count).by(1)
    end
  end

  describe "GET 'confirm'" do
    it "returns http success" do
      get 'confirm'
      response.should be_success
    end
  end
end
