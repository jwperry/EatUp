Rails.application.config.middleware.use OmniAuth::Builder do
  provider :meetup, ENV["MEETUP_CONSUMER_KEY"], ENV["MEETUP_CONSUMER_SECRET"]
end
