class DashboardPresenter < SimpleDelegator
  attr_reader :view, :current_user
  require 'date'

  def initialize(current_user, view)
    @view = view
    @current_user = current_user
    super(@current_user)
  end

  def historical_events
    @current_user.events
  end

  def display_local_time(event)
    time = (((event.time + event.utc_offset).to_f)/1000).to_s
    date = DateTime.strptime(time, '%s')
    date.strftime("%m/%d/%Y %l:%M %P")
  end

  def current_events
    current_time = DateTime.now.strftime('%Q').to_i
    @current_user.events.select do |event|
      ((event.time + event.utc_offset) - (current_time + event.utc_offset)) <= 604800000
    end.reverse
  end
end
