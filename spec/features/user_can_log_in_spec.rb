require 'rails_helper'

RSpec.feature "UserCanLogIn", vcr: true do
  describe "User can log in with Google credentials" do
    it "allows user to log in" do
      visit '/'

      click_on "Log In With Google"

      expect(page).to have_content("Joseph")
      expect(page).to have_content("Perry")
      expect(current_path).to eq("/dashboard")
    end
  end
end
