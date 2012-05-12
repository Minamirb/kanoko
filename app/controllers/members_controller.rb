# -*- coding: utf-8 -*-
class MembersController < ApplicationController
  before_filter :login_required

  def create
    @diary = current_user.diaries.find(params[:diary_id])
    member = @diary.members.new
    provider = params[:member][:provider]
    name = params[:member][:account_name]
    account = Account.find_by_provider_and_name(provider, name) || Account.create(provider: provider, name: name)
    member.user = account.create_user
    member.confirm_hash = Digest::SHA1.hexdigest(Time.now.to_f.to_s)
    member.save
    redirect_to diaries_path, :notice => name + "を招待しました"
  end

  def confirm
  end
end
