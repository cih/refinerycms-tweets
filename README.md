# Tweets for Refinery CMS

## About

Tweets allows you add a Twitter feed to your site in seconds.

## Features

- Use either a Twitter [widget](https://twitter.com/settings/widgets) or a jQuery implementation using the Public API
- JQuery implementation accepts an optional callback to override the default response rendering
- Twitter widget can be fully customised

Note: The Twitter widget doesn't require jQuery however if you choose to use the Public API jQuery is required.
I do plan to add a vanilla javascript implementation in future but pull requests are welcome!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'refinerycms-tweets'
```

Next run:

    bundle
    rails generate refinery:tweets
    rake db:migrate

Now when you start up your Refinery application, there should be a new "Twitter" tab to manage the account.

## Usage

Just add an account and put the following into your view.

    <%= tweets %>

Note: If you do not have a view template already then you will need to override one, here is an example of how to do that.

    rake refinery:override view=refinery/_footer

## Configuration

By default the Twitter widget will be used if the twitter account has a username and widget_id. If there is a username but no widget_id
then it will fallback to use the jQuery list. This behaviour can be changed in the initializer as required.

```ruby
# config/initializers/refinery/tweets.rb

Refinery::Tweets.use_twitter_widget = true
Refinery::Tweets.fallback_to_jquery_tweet_list = true
```

### Customising

Just pass in you options as a hash. Here is an example using the twitter widget. You can see a fill list of options in the [docs](https://dev.twitter.com/docs/embedded-timelines#customization)

```erb
<%= tweets("data-chrome"=> "noheader", "data-theme" => "dark", :callback => "testalert") %>

<%= content_for :javascripts do %>
  <script>
    function testalert(response){
      alert(response);
    }
  </script>
<% end %>
```

In this case the callback will only be triggered if there is no widget_id.

## Screenshot

![Admin view of the Twitter account](http://cih-static.s3.amazonaws.com/refinerycms-tweets-screenshot.png)

## Testing

The refinerycms-testing gem allows you to generate a dummy app within the engine to run the tests against.

    rake refinery:testing:dummy_app
    rake spec

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
