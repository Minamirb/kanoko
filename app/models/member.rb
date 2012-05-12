# -*- coding: utf-8 -*-
class Member < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  def default_url_options
    Rails.application.config.action_controller.default_url_options
  end

  attr_accessible :user_id, :diary_id, :sort
  belongs_to :user
  belongs_to :diary
  has_many :articles

  attr_accessor :provider, :account_screen_name

  def prev_member
    prev = Member.where('diary_id = ? and sort < ?', diary.id, sort).order('sort').first
    prev ||= Member.where('diary_id = ?', diary.id).order('sort').last
  end

  def invite_notice(from)
    consumer = Rubytter::OAuth.new(TWITTER_OAUTH["CONSUMER_KEY"], TWITTER_OAUTH["CONSUMER_SECRET"]).create_consumer

    from = from.accounts.find_by_provider("twitter")
    to = user.accounts.find_by_provider("twitter")
    access_token = OAuth::AccessToken.new(consumer, from.token, from.secret)
    twitter = OAuthRubytter.new(access_token)
    url = diary_member_confirm_url(diary, self)
    begin
      twitter.update("@#{to.screen_name} 交換日記の招待がありました #{url}")
    rescue Rubytter::APIError => e
      Rails.logger.info(e)
    end
  end
end
