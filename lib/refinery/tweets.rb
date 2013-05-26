


require 'refinerycms-core'
# require 'refinerycms-settings'
# require "refinerycms/tweets/version"

module Refinery
  autoload :TweetsGenerator, 'generators/refinery/tweets/tweets_generator'
  module Tweets
    require 'refinery/tweets/engine'
    # require 'refinery/tweets/configuration'

    autoload :Version, 'refinery/tweets/version'

    class << self
      attr_writer :root

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join("spec/factories").to_s ]
      end
    end
  end
end

