class SchedulerPresenter < SimpleDelegator
  attr_reader :view, :model
  require 'json'

  def initialize(model, view)
    @view = view
    @model = model
    super(@model)
  end

  def matching_events
    service = MeetupService.new(model)
    events = service.matching_open_events + service.matching_group_events
    existing = model.events.map { |event| event.meetup_event_id }
    events.select { |event| !(existing.include?(event[:id])) }
  end

  def display_local_time(event)
    time = ((event[:time] + event[:utc_offset].to_f)/1000).to_s
    date = DateTime.strptime((time), '%s')
    date.strftime("%m/%d/%Y %l:%M %P")
  end

  def convert_to_json(event)
    event.to_json
  end
end
