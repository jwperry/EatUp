class UsersController < ApplicationController

  def dashboard
    @user = DashboardPresenter.new(current_user, view_context)
  end

  def scheduler
    @user = SchedulerPresenter.new(current_user, view_context)
  end

  private

end
