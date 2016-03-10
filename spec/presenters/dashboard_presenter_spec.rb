require 'rails_helper'

describe "DashboardPresenter" do

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
    @presenter = DashboardPresenter.new(@user, "test")
  end

  context "historical_events" do
    it "returns all user_events" do
      ApplicationController.any_instance.stubs(:current_user).returns(@user)
      expect(@presenter.historical_events.count).to eq(0)
    end
  end
end
