require 'rails_helper'

describe "MeetupService" do

  before do
    @user = User.create(name: "Joseph Perry",
                        first_name: "Joseph",
                        last_name: "Perry",
                        uid: ENV["UID"],
                        provider: "google_oauth2",
                        email: "joseph.w.perry@gmail.com",
                        image: "https://lh4.googleusercontent.com/-lbxDygyyK8U/AAAAAAAAAAI/AAAAAAAAABI/IbZcoygAmGY/photo.jpg",
                        token: ENV["USER_TOKEN"],
                        expires_at: ENV["EXPIRES_AT"])
    @meetup_service = MeetupService.new(@user)
  end

  # context "#cities" do
  #   it "returns cities" do
  #     VCR.use_cassette("meetup_service#cities") do
  #       cities = @meetup_service.cities
  #       city = cities.first
  #       binding.pry
  #     end
  #   end
  # end

  # context "#categories" do
  #   it "returns categories" do
  #     VCR.use_cassette("meetup_service#categories") do
  #       categories = @meetup_service.categories
  #       binding.pry
  #     end
  #   end
  # end

  # context "#dashboard" do
  #   it "returns dashboard" do
  #     VCR.use_cassette("meetup_service#dashboard") do
  #       dashboard = @meetup_service.dashboard
  #       binding.pry
  #     end
  #   end
  # end

  # context "#groups" do
  #   it "returns groups" do
  #     VCR.use_cassette("meetup_service#groups") do
  #       groups = @meetup_service.groups
  #       binding.pry
  #     end
  #   end
  # end

end
