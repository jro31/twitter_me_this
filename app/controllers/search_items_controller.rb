class SearchItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def show
    @query = '19johnsmith63'
    @follower_screen_names = follower_screen_names
  end

  private

  def follower_screen_names
    follower_ids.map { |follower_id| client.user(follower_id).screen_name }
    # ["aftgomes", "TommyToeHold"] # Mock screen names
  end

  def follower_ids
    @follower_ids ||= client.follower_ids('everton', {count: 5} )&.to_a # Check that 'count' works
    raise
    # [2233382765, 1302890415557877765] # Mock IDs
  end

  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key    = ENV["TWITTER_API_KEY"]
      config.consumer_secret = ENV["TWITTER_SECRET_KEY"]
      config.bearer_token    = ENV["TWITTER_BEARER_TOKEN"]
    end
  end
end
