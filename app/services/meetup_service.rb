require 'open-uri'

class MeetupService
  attr_reader :connection

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

  def group_events
    parse(connection.get("/2/events?member_id=#{@current_user.meetup_id}"))
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
