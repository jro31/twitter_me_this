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
      client.follower_ids(@query, { count: 200 })&.to_a
    rescue StandardError => e
      puts "🎉🎉 Unable to fetch IDs 🎉🎉"
      puts "❌❌ #{e} ❌❌"
      @error = e
      [1298668370611642375, 1267077658958913536, 2367750224, 952225840925851648, 1161392051033903104, 125383342, 1124484786217725953, 632339607, 587312557, 3064016627, 1062022143754428417, 1057600918588481536, 779247451693785088, 1043682815634812929, 1020677330489020418, 829203191808008194, 810767070, 978711034465681408, 956898079831031808, 542733730, 894615371554181121, 324662000, 878974777603612672, 867575622779887616, 717724339567611904, 862346729026232320, 3300435831, 846215819394723840, 820645181145772032, 596394853, 443284360, 701513031621156866, 29648762, 753586521723248640, 747784483915632641, 1168991636, 3227366796, 558512291, 3089731606]
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
