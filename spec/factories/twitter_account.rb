FactoryGirl.define do
  factory :twitter_account, :class => Refinery::Tweets::TwitterAccount do
    username "twitter"
    tweet_count 8
    widget_id "123456789"
    visible true
  end
end
