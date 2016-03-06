require 'rails_helper'

describe "MeetupService" do

  before do
    @user = User.create(name: "Luke Mantree",
                        meetup_id: 200961493,
                        photo: "http://photos4.meetupstatic.com/photos/member/7/8/2/9/highres_254490761.jpeg",
                        city: "Denver",
                        state: "CO",
                        country: "us",
                        lat: 39.75,
                        lon: 104.99,
                        token: ENV["USER_TOKEN"])
    @meetup_service = MeetupService.new(@user)
  end

  context "#groups" do
    it "returns groups" do
      VCR.use_cassette("meetup_service#groups") do
        groups = @meetup_service.groups
      end
    end
  end  

end
