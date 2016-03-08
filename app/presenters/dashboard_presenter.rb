class DashboardPresenter < SimpleDelegator
  attr_reader :view, :model
  require 'date'

  def initialize(model, view)
    @view = view
    @model = model
    super(@model)
  end

  def historical_events
    @model.events
  end

  def display_local_time(event)
    time = (((event.time + event.utc_offset).to_f)/1000).to_s
    date = DateTime.strptime((time), '%s')
    date.strftime("%m/%d/%Y %l:%M %P")
  end

  def current_events
    current_time = DateTime.now.strftime('%Q').to_i
    @model.events.select do |event|
      ((event.time + event.utc_offset) - (current_time + event.utc_offset)) <= 604800000
    end.reverse
  end
end
