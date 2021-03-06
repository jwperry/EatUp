FactoryGirl.define do

  factory :user do
    meetup_id
    status
    name
    city
    state "CO"
    country "us"
    photo "http://photos4.meetupstatic.com/photos/member/7/8/2/9/highres_254490761.jpeg"
    lat
    lon
    token ENV["USER_TOKEN"]

    factory :user_with_events do
      transient do
        transactions_count 5
      end
      after(:create) do |user, evaluator|
        create_list(:event, evaluator.transactions_count, user: user)
      end
    end
  end

  factory :event do
    utc_offset -25200000
    country "us"
    city
    state "CO"
    distance
    description
    name
    meetup_event_id
    time
    group
    status
  end

  sequence :meetup_id do |n|
    n
  end

  sequence :status do |n|
    "status#{n}"
  end

  sequence :name do |n|
    "name#{n}"
  end

  sequence :city do |n|
    "city#{n}"
  end

  sequence :lat do |n|
    30 + n
  end

  sequence :lon do |n|
    -100 - n
  end

  sequence :zip do |n|
    (11111 + n).to_s
  end

  sequence :distance do |n|
    n
  end

  sequence :description do |n|
    "Thank you to everyone who volunteered for the inaugural[masked] event " \
    "last year! It was awesome, but we need your help again! We’re gearing " \
    "up for yet another great event in June. Please join us for the " \
    "first volunteer on boarding session where we’ll discuss in detail how " \
    "you can be involved this year. For those of you who are new, we’ll get " \
    "you acquainted with the program and help connect you with the volunteer " \
    "role that’s right for you. Light snacks and refreshments will " \
    "be served. If you have any questions, please contact [redacted] " \
    "at [masked]."
  end

  sequence :meetup_event_id do |n|
    "event_id_#{n}"
  end

  sequence :time do |n|
    (1457820000000) + (n*10000000)
  end

  sequence :group do |n|
    "group#{n}"
  end
end
