module Refinery
  class TweetsGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def generate_tweets_initializer
      template 'config/initializers/refinery/tweets.rb.erb', File.join(destination_root, 'config', 'initializers', 'refinery', 'tweets.rb')
    end

    def rake_db
      rake("refinery_tweets:install:migrations")
      # rake("refinery_settings:install:migrations")
    end

    def append_load_seed_data
      create_file 'db/seeds.rb' unless File.exists?(File.join(destination_root, 'db', 'seeds.rb'))
      append_file 'db/seeds.rb', :verbose => true do
        <<-EOH

# Added by Refinery CMS Tweets engine
Refinery::Tweets::Engine.load_seed
        EOH
      end
    end
  end
end
