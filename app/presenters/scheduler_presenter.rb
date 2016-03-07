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
    open = service.matching_open_events
    group = service.matching_group_events
    group + open
  end

  def display_local_time(event)
    time = ((event[:time] + event[:utc_offset].to_f)/1000).to_s
    date = DateTime.strptime((time), '%s')
    date.strftime("%m/%d/%Y %l:%M %P")
  end

  def convert_to_json(event)
    event.to_json
  end

  def wrap_matches(events)
  end
end
