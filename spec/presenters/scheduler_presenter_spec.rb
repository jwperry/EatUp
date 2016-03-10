require 'rails_helper'
require 'json'

describe "SchedulerPresenter", vcr: true do

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
      @presenter = SchedulerPresenter.new(@user, "Test")
  end

  context "matching_events" do
    it "returns user's matching events" do
      VCR.use_cassette("scheduler#matches") do
        ApplicationController.any_instance.stubs(:current_user).returns(@user)
        matches = @presenter.matching_events
        expect(matches.count).to be > 0
        expect(matches.first[:venue]).to_not be nil
        expect(matches.first[:description]).to_not be nil
        expect(matches.first[:name]).to_not be nil
        expect(matches.first[:group]).to_not be nil
        expect(matches.first[:status]).to_not be nil
      end
    end
  end

  context "display_local_time" do
    it "converts to local time" do
      user = create(:user_with_events)
      event = user.events.first
      presenter = SchedulerPresenter.new(user, "test")
      date_string = presenter.display_local_time(event)
      expect(date_string).to eq("03/14/2016 12:20 am")
    end
  end

  context "convert_to_json" do
    it "converts to json" do
      event = create(:event)
      json_event = @presenter.convert_to_json(event)
      returned = JSON.parse(json_event)
      expect(event[:id]).to eq(returned["id"])
      expect(event[:description]).to eq(returned["description"])
      expect(event[:name]).to eq(returned["name"])
      expect(event[:meetup_event_id]).to eq(returned["meetup_event_id"])
    end
  end  
end
