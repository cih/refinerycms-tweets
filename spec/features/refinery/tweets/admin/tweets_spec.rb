require "spec_helper"

module Refinery
  module Tweets
    module Admin

      describe TwitterAccount do
        refinery_login

        let!(:twitter_account) do
          FactoryGirl.create(:twitter_account, :username => "Chris Holmes",
                                    :tweet_count => 5,
                                    :widget_id => "123456789",
                                    :visible => true)
        end

        context "when no account" do
          before(:each) { Refinery::Tweets::TwitterAccount.destroy_all }

          context "twitter account" do
            it "shows message" do
              visit refinery.tweets_admin_twitter_account_path

              expect(page).to have_content("You don't have a Twitter account listed")
            end

            it "has add account link" do
              visit refinery.tweets_admin_twitter_account_path

              expect(page).to have_link(
                'Add a Twitter account',
                href: refinery.new_tweets_admin_twitter_account_path
              )
            end
          end
        end

        context "when account" do
          it "does not have link to add account" do
            visit refinery.tweets_admin_twitter_account_path

            expect(page).not_to have_content("You don't have a Twitter account listed")
            expect(page).not_to have_link(
              'Add a Twitter account',
              href: refinery.new_tweets_admin_twitter_account_path
            )
          end
        end

        describe "show" do
          it "has account details" do
            visit refinery.tweets_admin_twitter_account_path

            expect(page).to have_content("Your Twitter Account")
            expect(page).to have_content("Username")
            expect(page).to have_content("Number of tweets")
            expect(page).to have_content("Visible")
          end

          it "has edit link" do
            visit refinery.tweets_admin_twitter_account_path

            expect(page).to have_link(
              'Edit Twitter account',
              href: refinery.edit_tweets_admin_twitter_account_path
            )
          end

          it "has delete link" do
            visit refinery.tweets_admin_twitter_account_path

            expect(page).to have_link(
              'Delete Twitter account',
              href: refinery.tweets_admin_twitter_account_path
            )
          end
        end

        describe "destroy" do
          it "removes account" do
            visit refinery.tweets_admin_twitter_account_path

            click_link "Delete Twitter account"

            expect(page).to have_content("You don't have a Twitter account listed")
          end

          it "clears the cached settings" do
            visit refinery.tweets_admin_twitter_account_path

            click_link "Delete Twitter account"

            expect(Rails.cache.read('refinery-twitter-account-settings')).to eq nil
          end
        end
      end
    end
  end
end
