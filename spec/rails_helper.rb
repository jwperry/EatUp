# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "spec_helper"
require "rspec/rails"
require "factory_girl_rails"
require "pry"
require "vcr"
require "capybara/rails"
require "capybara/rspec"

Capybara.javascript_driver = :selenium
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

VCR.configure do |c|
  c.cassette_library_dir = "spec/vcr"
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = true
end

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end


  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end


  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end


  config.before(:each) do
    DatabaseCleaner.start
  end


  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.include FactoryGirl::Syntax::Methods
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

# OmniAuth.config.test_mode = true
# OmniAuth.config.mock_auth[:meetup] =
#             OmniAuth::AuthHash.new(info: { name: "Luke Mantree",
#                                            meetup_id: 230982308723,
#                                            photo: "http://photos4.meetupstatic.com/photos/member/7/8/2/9/highres_254490761.jpeg",
#                                            city: "Denver",
#                                            state: "CO",
#                                            country: "us",
#                                            lat: 39.75,
#                                            lon: 104.99
#                                            },
#                                    credentials: { token: ENV["USER_TOKEN"] })
# end

# {:id=>200961493,
#  :name=>"Luke Mantree",
#  :status=>"active",
#  :joined=>1457206499000,
#  :city=>"Denver",
#  :country=>"us",
#  :localized_country_name=>"USA",
#  :state=>"CO",
#  :lat=>39.75,
#  :lon=>-104.99,
#  :photo=>
#   {:id=>254490761,
#    :highres_link=>"http://photos4.meetupstatic.com/photos/member/7/8/2/9/highres_254490761.jpeg",
#    :photo_link=>"http://photos4.meetupstatic.com/photos/member/7/8/2/9/member_254490761.jpeg",
#    :thumb_link=>"http://photos4.meetupstatic.com/photos/member/7/8/2/9/thumb_254490761.jpeg"}}

# OmniAuth.config.mock_auth[:meetup] =
#             OmniAuth::AuthHash.new(provider: "google_oauth2",
#                                    uid: ENV["UID"],
#                                    info: { name: "Joseph Perry",
#                                            email: "joseph.w.perry@gmail.com",
#                                            first_name: "Joseph",
#                                            last_name: "Perry",
#                                            image: "https://lh4.googleusercontent.com/-lbxDygyyK8U/AAAAAAAAAAI/AAAAAAAAABI/IbZcoygAmGY/photo.jpg",
#                                            },
#                                    credentials: { token: ENV["USER_TOKEN"], expires_at: ENV["EXPIRES_AT"] })
# end