module Refinery
  module Tweets
    module Admin
      class TwitterAccountsController < ::Refinery::AdminController

        def show
          @twitter_account = TwitterAccount.first
        end

        def new
          @twitter_account = TwitterAccount.new
        end

        def create
          @twitter_account = TwitterAccount.new(twitter_account_params)

          if @twitter_account.save
            render :show
          else
            redirect_to refinery.new_tweets_admin_twitter_account_path
          end
        end

        def edit
          @twitter_account = TwitterAccount.first

          if @twitter_account
            render :edit
          else
            render :show
          end
        end

        def update
          @twitter_account = TwitterAccount.first
          @twitter_account.update_attributes(twitter_account_params)

          render :show
        end

        def destroy
          @twitter_account = TwitterAccount.first
          if @twitter_account.destroy
            Rails.cache.delete("refinery-twitter-account-settings")
          end

          redirect_to refinery.tweets_admin_twitter_account_path
        end

      private
      
        def twitter_account_params
            params.require(:twitter_account).permit(:username, :tweet_count, :widget_id, :visible)
          end

      end
    end
  end
end