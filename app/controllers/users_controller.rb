class UsersController < ApplicationController
  before_action :set_current_user, only: [:edit, :update]

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to dashboard_path
    else
      flash.now[:error] = "Incorrect user information"
      render :edit
    end
  end

  def dashboard
    @user = DashboardPresenter.new(current_user, view_context)
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end
end
