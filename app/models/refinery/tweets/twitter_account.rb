require 'refinery/core/base_model'

module Refinery
  module Tweets
    class TwitterAccount < Refinery::Core::BaseModel

      attr_accessible :username, :tweet_count, :widget_id, :visible

      validate :only_one_account, :on => :create
      validates_presence_of :username, :tweet_count

      after_save :update_settings_cache

      class << self

        def account
          first
        end

        def account_settings
          Rails.cache.read('refinery-twitter-account-settings')
        end

        def update_settings!
          Rails.cache.write('refinery-twitter-account-settings', generate_settings_hash!)
        end

        def generate_settings_hash!
          settings_hash = {}
          attributes = %w(username tweet_count visible widget_id)
          attributes.each do |key|
            settings_hash.merge!(key => account.send(key.to_sym))
          end
          settings_hash
        end
      end

      def name
        "Admin"
      end

      def title
        "Admin"
      end

      private

      def update_settings_cache
        self.class.update_settings!
      end

      def only_one_account
        if self.class.account
          errors[:base] << "You can only have one Twitter account."
        end
      end
    end
  end
end