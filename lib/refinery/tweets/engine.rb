module Refinery
  module Tweets
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery::Tweets

      initializer 'load helper' do |app|
        ActiveSupport.on_load :action_controller do
          helper Refinery::Tweets::TweetsHelper
        end
      end

      initializer "init plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = "refinerycms_tweets"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.tweets_admin_twitter_account_path }
          plugin.menu_match = %r{refinery/tweets(/.+?)?$}
          plugin.activity = {
            :class_name => :'refinery/tweets/twitter_account',
            :title => 'name',
            :url_prefix => nil,
            :url => 'refinery.tweets_admin_twitter_account_path'
          }
        end
      end

      config.after_initialize do
        Refinery.register_engine(Refinery::Tweets)
      end
    end
  end
end
