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
          @twitter_account = TwitterAccount.new(params[:twitter_account])

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
          @twitter_account.update_attributes(params[:twitter_account])

          render :show
        end

        def destroy
          @twitter_account = TwitterAccount.first
          if @twitter_account.destroy
            Rails.cache.delete("refinery-twitter-account-settings")
          end

          redirect_to refinery.tweets_admin_twitter_account_path
        end
      end
    end
  end
end