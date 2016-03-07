class Event < ActiveRecord::Base
  belongs_to :user

  def self.create_events_by_params(events, current_user)
    events.each do |event|
      converted_time = convert_time(event["time"], event["utc_offset"])
      new_event = Event.create(user_id: current_user.id,
                               utc_offset: event["utc_offset"],
                               country: event["venue"]["country"],
                               city: event["venue"]["city"],
                               state: event["venue"]["state"],
                               distance: event["distance"],
                               name: event["name"],
                               meetup_event_id: event["id"],
                               time: converted_time,
                               group: event["group"]["name"],
                               status: event["status"])
      new_event.save
      current_user.events << new_event
    end
  end

  def self.convert_time(time, offset)
    local = (((time + offset).to_f)/1000).to_s
    actual = DateTime.strptime((local), '%s')
    actual.strftime("%m/%d/%Y %l:%M %P")
  end
end
