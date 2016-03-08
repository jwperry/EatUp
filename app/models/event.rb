class Event < ActiveRecord::Base
  belongs_to :user

  def self.create_events_by_params(events, current_user)
    events.each do |event|
      new_event = Event.create(user_id: current_user.id,
                               utc_offset: event["utc_offset"],
                               country: event["venue"]["country"],
                               city: event["venue"]["city"],
                               state: event["venue"]["state"],
                               distance: event["distance"],
                               name: event["name"],
                               meetup_event_id: event["id"],
                               time: event["time"],
                               group: event["group"]["name"],
                               description: event["description"],
                               status: event["status"])
      new_event.save
      current_user.events << new_event
    end
  end
end
