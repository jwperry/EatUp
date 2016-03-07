class UsersController < ApplicationController

  def dashboard
    @presenter = DashboardPresenter.new(current_user, view_context)
  end

  def scheduler
    @presenter = SchedulerPresenter.new(current_user, view_context)
  end

  private

end
