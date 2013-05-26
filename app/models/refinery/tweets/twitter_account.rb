require 'refinery/core/base_model'

module Refinery
  module Tweets
    class TwitterAccount < Refinery::Core::BaseModel

      attr_accessible :username, :tweet_count, :visible

      validate :only_one_account, :on => :create
      validates_presence_of :username, :tweet_count, :visible

      after_commit :update_settings!

      class << self
        def account_settings
          $tweets_twitter_account ||= generate_settings_hash!
        end

        def update_settings!
          $tweets_twitter_account = generate_settings_hash!
        end

        def generate_settings_hash!
          settings_hash = {}
          attributes = columns.map {|c| c.name}
          attributes.each do |key|
            settings_hash.merge!(key => self.send(key.to_sym))
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

      def only_one_account
        if TwitterAccount.count != 0
          errors[:base] << "You can only have one Twitter account."
        end
      end
    end
  end
end