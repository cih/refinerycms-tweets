class CreateTwitterAccounts < ActiveRecord::Migration
  def up
    unless ::Refinery::Tweets::TwitterAccount.table_exists?
      create_table :refinery_tweets_twitter_accounts, :force => true do |t|
        t.string   :username
        t.integer  :tweet_count, :default => 5
        t.string   :widget_id
        t.boolean  :visible, :default => true
        t.timestamps
      end
    end
  end

  def down
     drop_table ::Refinery::Tweets::TwitterAccount.table_name
  end
end