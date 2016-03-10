class User < ActiveRecord::Base
  has_many :events

  def self.find_or_create_by_auth(response, user_info)
    user = User.find_or_create_by(meetup_id: user_info[:id])
    user.name = user_info[:name]
    user.status = user_info[:status]
    user.city = user_info[:city]
    user.country = user_info[:country]
    user.state = user_info[:state]
    user.lat = user_info[:lat]
    user.lon = user_info[:lon]
    user.photo = user_info[:photo][:photo_link]
    user.token = response[:access_token]
    user.save
    
    user
  end
end
