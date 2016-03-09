class UsersController < ApplicationController

  def dashboard
    if current_user
      @presenter = DashboardPresenter.new(current_user, view_context)
    else
      redirect_to root_path
    end
  end

  def scheduler
    if current_user
      @presenter = SchedulerPresenter.new(current_user, view_context)
    else
      redirect_to root_path
    end
  end

  private

end
