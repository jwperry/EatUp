require 'rails_helper'

RSpec.feature "LoggedInUserCanAccessPages", vcr: true do
  describe "User can view dashboard/scheduler" do

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
    end

    it "allows user to log in" do
      VCR.use_cassette("sessions#create") do
        ApplicationController.any_instance.stubs(:current_user).returns(@user)
        visit '/'
        expect(current_path).to eq("/")
        visit '/dashboard'
        expect(current_path).to eq("/dashboard")
        visit '/scheduler'
        expect(current_path).to eq("/scheduler")
      end
    end
  end
end
