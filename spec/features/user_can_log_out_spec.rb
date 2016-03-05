require 'rails_helper'

RSpec.feature "UserCanLogOut", vcr: true do
  describe "User can log out and is redirected to root" do
    it "allows user to log out" do
      visit '/'

      click_on "Log In With MeetUp"

      expect(page).to have_content("Joseph")
      expect(page).to have_content("Perry")
      expect(current_path).to eq("/dashboard")

      click_on "Log out"

      expect(current_path).to eq("/")
    end
  end
end
