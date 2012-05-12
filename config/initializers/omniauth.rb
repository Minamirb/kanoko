# -*- coding: utf-8 -*-

TWITTER_OAUTH = if Rails.env.production?
                  {"CONSUMER_KEY" => ENV["TWITTER_CONSUMER_KEY"], "CONSUMER_SECRET" => ENV["TWITTER_CONSUMER_SECRET"]}
                else
                  YAML::load(File.open("config/twitter.yml"))
                end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, TWITTER_OAUTH["CONSUMER_KEY"], TWITTER_OAUTH["CONSUMER_SECRET"]
end
