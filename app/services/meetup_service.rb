require 'open-uri'

class MeetupService
  attr_reader :connection

  def initialize(current_user)
    @current_user = current_user
    @connection = Faraday.new(url: "https://api.meetup.com") do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.params[:access_token] = ENV["MEETUP_API_KEY"]
    end
  end

  def cities
    parse(connection.get("/2/cities"))
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
