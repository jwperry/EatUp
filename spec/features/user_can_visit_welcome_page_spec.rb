require 'rails_helper'

RSpec.feature "UserCanVisitWelcomePage" do
  describe "GET /" do
    
    it "allows user to visit welcome page" do
      visit "/"
      expect(current_path).to eq("/")
      expect(page).to have_content("EatUp")
      expect(page).to_not have_content("Dashboard")
      expect(page).to have_content("Log in")
      expect(page).to have_content("Log In With MeetUp")
    end
  end
end
