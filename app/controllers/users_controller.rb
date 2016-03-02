class UsersController < ApplicationController

  def dashboard
    @user = DashboardPresenter.new(current_user, view_context)
  end

  private

end
