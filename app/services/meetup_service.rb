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

  # def groups
  #   parse(connection.get("/2/groups?member_id=#{@current_user.meetup_id}"))
  # end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
