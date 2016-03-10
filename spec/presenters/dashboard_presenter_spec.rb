require 'rails_helper'
require 'date'

describe "DashboardPresenter" do
  context "historical_events" do
    it "returns all user_events" do
      user = create(:user_with_events)
      expect(user.events.count).to eq(5)
      presenter = DashboardPresenter.new(user, "test")
      ApplicationController.any_instance.stubs(:current_user).returns(user)
      expect(presenter.historical_events.count).to eq(5)
      expect(user.events.first.id).to eq(presenter.historical_events.first.id)
    end
  end

  context "display_local_time" do
    it "converts to local time" do
      user = create(:user_with_events)
      event = user.events.first
      presenter = DashboardPresenter.new(user, "test")
      date_string = presenter.display_local_time(event)
      expect(date_string).to eq("03/13/2016 10:26 am")
    end
  end

  context "current_events" do
    it "returns current events only" do
      user = create(:user)
      current_time = DateTime.now.strftime('%Q').to_i
      matching_time = current_time + 86400000
      failing_time = current_time + 864000000
      matching_event = create(:event, time: matching_time, utc_offset: 0)
      failing_event = create(:event, time: failing_time, utc_offset: 0)
      user.events << matching_event << failing_event
      presenter = DashboardPresenter.new(user, "test")
      matches = presenter.current_events
      expect(user.events.count).to eq(2)
      expect(matches.count).to eq(1)
      expect(matches.first.id).to eq(matching_event.id)
    end
  end
end
