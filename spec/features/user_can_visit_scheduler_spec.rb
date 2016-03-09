require 'rails_helper'

RSpec.feature "UserCanVisitScheduler", vcr: true do
  describe "GET /scheduler" do
    
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
    
    it "allows user to visit the scheduler" do
      VCR.use_cassette("users#scheduler") do
        ApplicationController.any_instance.stubs(:current_user).returns(@user)
        visit "/scheduler"
        expect(current_path).to eq("/scheduler")
        expect(page).to have_content("AVAILABLE EVENTS")
        expect(page).to have_content("SELECTED EVENTS")
        within(".scheduler-events-card-wrapper") do
          expect(page).to have_css(".scheduler-event-wrapper")
        end
        within(".scheduler-selected-card-wrapper") do
          expect(page).to_not have_css(".scheduler-event-wrapper")
        end
      end
    end
  end
end
