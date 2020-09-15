class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home;end

  def display_followers
    @query = params[:query]
    @follower_ids = follower_ids
    @follower_details = follower_details

    if !@follower_details || @follower_details.empty?
      flash[:alert] = @error || "Something went wrong. Please try again later."
      redirect_to root_path
    elsif current_user
      @search_item = current_user.search_items.new(query: @query)
      @follower_details.each do |key, value|
        @search_item.search_results.build(search_item: @search_item, twitter_id_number: key, twitter_screen_name: value)
      end
    end
  end

  private

  def follower_details
    return unless @follower_ids

    followers = {}
    @follower_ids.each do |follower_id|
      begin
        followers[follower_id.to_s] = client.user(follower_id).screen_name
      rescue StandardError => e
        puts "🎉🎉 Unable to fetch screen name 🎉🎉"
        puts "❌❌ #{e} ❌❌"
        next
      end
    end
    followers
  end

  def follower_ids
    begin
      # client.follower_ids(@query, { count: 5 })&.to_a
      client.friend_ids(@query, { count: 200 })&.to_a
    rescue StandardError => e
      puts "🎉🎉 Unable to fetch IDs 🎉🎉"
      puts "❌❌ #{e} ❌❌"
      @error = e
      nil
    end
  end

  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key    = ENV["TWITTER_API_KEY"]
      config.consumer_secret = ENV["TWITTER_SECRET_KEY"]
      config.bearer_token    = ENV["TWITTER_BEARER_TOKEN"]
    end
  end
end
