require 'rails_helper'
include Key

describe "MeetupService" do

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
  end

  context "#open_events" do
    it "returns open_events" do
      VCR.use_cassette("meetup_service#open_events") do
        open_events = @meetup_service.open_events
        expect(open_events[:results].count).to be > 0
        expect(open_events[:results].first.has_key?(:utc_offset)).to be true
        expect(open_events[:results].first.has_key?(:visibility)).to be true
        expect(open_events[:results].first.has_key?(:created)).to be true
        expect(open_events[:results].first.has_key?(:description)).to be true
        expect(open_events[:results].first.has_key?(:group)).to be true
      end
    end
  end

  context "#matching_open_events" do
    it "returns matching_open_events" do
      VCR.use_cassette("meetup_service#matching_open_events") do
        matching_open_events = @meetup_service.matching_open_events
        all_matches = matching_open_events.all? do |event|
          match_key.any? { |word| event[:description].include?(word) }
        end
        expect(all_matches).to be true
      end
    end
  end

  context "#group_events" do
    it "returns group_events" do
      VCR.use_cassette("meetup_service#group_events") do
        group_events = @meetup_service.group_events
        expect(group_events[:results].count).to be > 0
        expect(group_events[:results].first.has_key?(:utc_offset)).to be true
        expect(group_events[:results].first.has_key?(:visibility)).to be true
        expect(group_events[:results].first.has_key?(:created)).to be true
        expect(group_events[:results].first.has_key?(:description)).to be true
        expect(group_events[:results].first.has_key?(:group)).to be true
      end
    end
  end

  context "#matching_group_events" do
    it "returns matching_group_events" do
      VCR.use_cassette("meetup_service#matching_group_events") do
        matching_group_events = @meetup_service.matching_group_events
        all_matches = matching_group_events.all? do |event|
          match_key.any? { |word| event[:description].include?(word) }
        end
        expect(all_matches).to be true
      end
    end
  end
end
