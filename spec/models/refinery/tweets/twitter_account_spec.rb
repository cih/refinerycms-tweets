require 'spec_helper'

module Refinery
  module Tweets
    describe TwitterAccount do
      describe "validations" do
        subject do
          Factory.build(:twitter_account,
                        :username => "twitter",
                        :tweet_count => "5")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:username) { should == "twitter" }
        its(:tweet_count) { should == 5 }
        its(:visible) { should == true }
      end

      describe "account settings" do

        before(:each) do
          Rails.cache.clear
        end

        it "stores the settings in the rails cache" do
          Rails.cache.read('refinery-twitter-account-settings').should be_nil
          twitter_account = FactoryGirl.create(:twitter_account)

          Rails.cache.read('refinery-twitter-account-settings').should == settings_hash(twitter_account)
        end

        it "reads the settings from the rails cache" do
          twitter_account = FactoryGirl.create(:twitter_account)

          TwitterAccount.account_settings.should == settings_hash(twitter_account)
        end

        it "updates the cache when the settings are changed" do
          twitter_account = FactoryGirl.create(:twitter_account)

          TwitterAccount.account_settings.should == settings_hash(twitter_account)
          TwitterAccount.account_settings["username"].should == "twitter"

          twitter_account.update_attribute(:username, "new_username")

          TwitterAccount.account_settings.should == settings_hash(twitter_account)
          TwitterAccount.account_settings["username"].should == "new_username"
        end

      end

    end
  end
end