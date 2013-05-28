module Refinery
  module Tweets
    include ActiveSupport::Configurable

    config_accessor :fallback_to_jquery_tweet_list
    config_accessor :use_twitter_widget

    self.fallback_to_jquery_tweet_list = true
    self.use_twitter_widget = true
  end
end