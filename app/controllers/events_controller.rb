class EventsController < ApplicationController

  def create
    Event.create_events_by_params(params["_json"], current_user)
    render nothing: true
  end

end
