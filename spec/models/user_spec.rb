require 'rails_helper'

RSpec.describe User, type: :model do
  describe "find_or_create_by_auth" do
    it "creates a new user from user_info hash" do
      response = {:access_token=>"test_access_token", 
                  :refresh_token=>"test_refresh_token", 
                  :token_type=>"bearer", :expires_in=>72576000}
      user_info = {:id=>111222333,
                   :name=>"Luke Mantree",
                   :status=>"active",
                   :joined=>1457206499000,
                   :city=>"Denver",
                   :country=>"us",
                   :localized_country_name=>"USA",
                   :state=>"CO",
                   :lat=>39,
                   :lon=>-104,
                   :photo=> {:id=>254490761,
                             :highres_link=>"http://photos4.meetupstatic.com/photos/member/7/8/2/9/highres_254490761.jpeg",
                             :photo_link=>"http://photos4.meetupstatic.com/photos/member/7/8/2/9/member_254490761.jpeg",
                             :thumb_link=>"http://photos4.meetupstatic.com/photos/member/7/8/2/9/thumb_254490761.jpeg"}}
      expect(User.count).to eq(0)
      User.find_or_create_by_auth(response, user_info)
      expect(User.count).to eq(1)
      expect(User.first.name).to eq(user_info[:name])
      expect(User.first.status).to eq(user_info[:status])
      expect(User.first.city).to eq(user_info[:city])
      expect(User.first.country).to eq(user_info[:country])
      expect(User.first.state).to eq(user_info[:state])
      expect(User.first.lat).to eq(user_info[:lat])
      expect(User.first.lon).to eq(user_info[:lon])
      expect(User.first.photo).to eq(user_info[:photo][:photo_link])
      expect(User.first.token).to eq(response[:access_token])
    end
  end
end
