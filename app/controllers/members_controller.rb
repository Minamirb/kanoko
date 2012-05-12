# -*- coding: utf-8 -*-
class MembersController < ApplicationController
  before_filter :login_required
  prepend_before_filter :memory_url, :only => :confirm

  def create
    @diary = current_user.diaries.find(params[:diary_id])
    provider = params[:member][:provider]
    screen_name = params[:member][:account_screen_name]
    account = Account.find_by_provider_and_screen_name(provider, screen_name)

    member = if account
               Member.find_by_user_id_and_diary_id(account.user.id, @diary.id)
             else
               @diary.members.new
             end

    unless account
      member.create_user.accounts.create(provider: provider, screen_name: screen_name)
    end
    member.confirm_hash = Digest::SHA1.hexdigest(Time.now.to_f.to_s)
    member.save
    member.invite_notice(current_user)
    redirect_to diaries_path, :notice => screen_name + "を招待しました"
  end

  def confirm
    @diary = Diary.find(params[:diary_id])
    @member = Member.find_by_user_id_and_diary_id(current_user.id, @diary.id)
    if request.put?
      @member.confirm = true
      @member.confirm_hash = nil
      @member.user.update_attributes(:name => @member.user.accounts.first.screen_name)
      @member.save!
      redirect_to diaries_path, :notice => "#{@diary.title} に参加しました"
    end
  end

  private
  def memory_url
    session[:url] = request.url
  end
end
