# require 'rails_helper'

# RSpec.feature "UserSelectAndClearEvents" do

#   let(:user){User.create(name: "Luke Mantree",
#                          meetup_id: 200961493,
#                          photo: "http://photos4.meetupstatic.com/photos/member/7/8/2/9/highres_254490761.jpeg",
#                          city: "Denver",
#                          state: "CO",
#                          country: "us",
#                          lat: 39.75,
#                          lon: 104.99,
#                          token: ENV["USER_TOKEN"])}

#   describe "User can select events" do

#     it "allows user to select an event", js: true do
#       VCR.use_cassette("users#scheduler") do
#         ApplicationController.any_instance.stubs(:current_user).returns(user)
#         visit '/scheduler'
#         expect(current_path).to eq("/scheduler")
#         within '.scheduler-selected-card-wrapper' do
#           expect(page).to_not have_selector(".scheduler-event-wrapper")
#         end
#         find(".test-button").click
#         find(".scheduler-event-wrapper", match: :first).click
#         sleep(5.second)
#         within '.scheduler-selected-card-wrapper' do
#           expect(page).to have_selector(".scheduler-event-wrapper")
#         end
#       end
#     end
#   end
# end


# def wait_for_ajax
#     Timeout.timeout(Capybara.default_max_wait_time) do
#       loop until finished_all_ajax_requests?
#     end
#   end

#   def finished_all_ajax_requests?
#     page.evaluate_script('jQuery.active').zero?
#   end