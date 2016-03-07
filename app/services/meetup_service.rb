require 'open-uri'

class MeetupService
  attr_reader :connection
  include Key

  def initialize(current_user)
    @current_user = current_user
    @connection = Faraday.new(url: "https://api.meetup.com") do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.params[:key] = ENV["MEETUP_API_KEY"]
      faraday.params[:sign] = "true"
      faraday.params[:access_token] = current_user.token
    end
  end

  def open_events
    parse(connection.get("/2/open_events?country=#{@current_user.country}&state=#{@current_user.state}&city=#{@current_user.city}"))
  end

  def matching_open_events
    events = self.open_events
    if events
      events[:results].select do |event|
        match_key.any? { |word| event[:description].include?(word) if event[:description] }
      end
    end
  end

  def group_events
    parse(connection.get("/2/events?member_id=#{@current_user.meetup_id}"))
  end

  def matching_group_events
    events = self.group_events
    if events
      events[:results].select do |event|
        match_key.any? { |word| event[:description].include?(word) if event[:description] }
      end
    end
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
