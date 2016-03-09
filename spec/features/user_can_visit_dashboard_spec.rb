require 'rails_helper'

RSpec.feature "UserCanVisitDashboard" do
  describe "GET /dashboard" do
    
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
    
    it "allows user to visit the dashboard" do
      ApplicationController.any_instance.stubs(:current_user).returns(@user)
      event = create(:event)
      @user.events << event
      visit "/dashboard"
      expect(current_path).to eq("/dashboard")
      within(".dashboard-user-card-wrapper") do
        expect(page).to have_content("Luke Mantree")
        expect(page).to have_content("Denver")
        expect(page).to have_content("CO")
        expect(page).to have_content("Scheduler")
      end
      expect(page).to have_content("THIS WEEK'S EVENTS")
      expect(page).to have_content("HISTORY OF SELECTED EVENTS")
      within(".dashboard-history-card-wrapper") do
        expect(page).to have_content(event.name)
      end
    end
  end
end
