require 'open-uri'

class MeetupService
  attr_reader :connection

  def initialize(current_user)
    @current_user = current_user
    @connection = Faraday.new(url: "https://api.meetup.com") do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.params[:key] = ENV["MEETUP_API_KEY"]
      faraday.params[:sign] = "true"
    end
  end

  def cities
    parse(connection.get("/2/cities"))
  end

  def categories
    parse(connection.get("/2/categories"))
  end

  def dashboard
    parse(connection.get("/2/dashboard"))
  end

  def groups
    parse(connection.get("/find/groups?zip=80202"))
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
