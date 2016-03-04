class SessionsController < ApplicationController
  before_action :set_mock if Rails.env.test?

  def index
  end

  def new
  end

  def create
    user = User.find_or_create_by_auth(request.env["omniauth.auth"])
    if user
      session[:user_id] = user.id
      @user = DashboardPresenter.new(current_user, view_context)
      redirect_to dashboard_path
    else
      flash[:error] = "Invalid login information."
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to "/"
  end

  private

  def set_mock
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google]
  end
end
