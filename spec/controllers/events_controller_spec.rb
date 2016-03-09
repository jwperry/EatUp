require "rails_helper"

describe "events" do
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

  describe "POST create" do
    it "creates a new event" do
      @controller = EventsController.new
      ApplicationController.any_instance.stubs(:current_user).returns(@user)
      expect(@user.events.count).to eq(0)
      params = { "_json" => [{ "user_id" => "1",
                               "utc_offset" => "100000000",
                               "venue" => { "country" => "us",
                                            "city" => "Denver",
                                            "state" => "CO" },
                               "distance" => "5",
                               "description" => "description",
                               "name" => "event_name",
                               "id" => "weoifaidfwq",
                               "time" => "1000000000000",
                               "group" => { "name" => "group_name" },
                               "status" => "status" }]}
      post :create, params
      expect(@user.events.count).to eq(1)
      event = @user.events.last
      expect(event.name).to eq("event_name")
      expect(event.group).to eq("group_name")
      expect(event.meetup_event_id).to eq("weoifaidfwq")
    end
  end
end
