module Refinery
  module Tweets
    module TweetsHelper

      # Twitter widget is enabled by default
      # It can be disabled in the initializer
      # config/initializers/refinery/tweets.rb
      #
      # The user will require a widget_id
      # If there is no widget id or the widget is
      # disabled in the config a simple js implementation
      # using the public API is used
      #
      def tweets(options={})
        return unless twitter_account_setup?
        if use_twitter_widget?
          twitter_widget(options)
        else
          tweet_list(options)
        end
      end

      def tweets_header
        tweets_account_link + " on Twitter"
      end

      def tweets_account_link
        link_to twitter_handle, refinery_tweets_url_for_account
      end

      def twitter_handle
        "@" + account_settings["username"]
      end

      def refinery_tweets_url_for_account
        "https://twitter.com/#{account_settings["username"]}"
      end

      private

      # The basic tweet takes an optional js callback
      # it returns a list of tweets based on
      # the tweet_count and username in the
      # Refinery::Tweets::TwitterAccount.account_settings
      #
      def tweet_list(options)
        if options[:callback]
          "bangarang"
        end

        content_for :javascripts do
          %Q[ <script type="text/javascript">
                $(function(){function e(e){output="";
                $.each(e,function(e,n){output+='<li class="refinery-tweets-list-item-'+e+"\\">";
                output+=t(n.text);output+="</li>"});
                $(".refinery-tweets-list").append(output)}
                function t(e){var t=/(\\b(https?|ftp|file):\\/\\/[-A-Z0-9+&@#\\/%?=~_|!:,.;]*[-A-Z0-9+&@#\\/%=~_|])/ig;
                return e.replace(t,"<a href='$1'>$1</a>")}$.ajax({
                url:"https://api.twitter.com/1/statuses/user_timeline/#{account_settings["username"]}.json?count=#{account_settings["tweet_count"]}",
                dataType:"jsonp",success:#{options[:callback] || "function(t){e(t)}"},error:function(e){console.log(e)}})})
              </script>].squish.html_safe
        end

         %Q[<ul class="refinery-tweets-list">
            <h3>#{tweets_header}</h3>
            </ul>].html_safe
      end

      # See a full list of options here
      # https://dev.twitter.com/docs/embedded-timelines#customization
      #
      def twitter_widget(options={})
        %Q[ <a class="twitter-timeline #{options[:class]}"
            #{to_html_options(options)}
            href="https://twitter.com/#{account_settings["username"]}"
            data-widget-id="#{account_settings["widget_id"]}">
            Tweets by @#{account_settings["username"]}</a>

            <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],
              p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id))
              {js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";
              fjs.parentNode.insertBefore(js,fjs);}} (document,"script","twitter-wjs");
            </script>
          ].squish.html_safe
      end

      def account_settings
        Refinery::Tweets::TwitterAccount.account_settings
      end

      def use_twitter_widget?
        account_settings["widget_id"].present?
      end

      def twitter_account_setup?
        true
      end

      # Convert the options to html attributes
      # eg. :width => 300 would convert to width="300"
      #
      def to_html_options(options)
        return if options.empty?

        options.delete(:class) if options[:class].present?

        output = ""
        options.each do |k, v|
          output += %Q[#{k.to_s}="#{v}" ]
        end

        output
      end
    end
  end
end