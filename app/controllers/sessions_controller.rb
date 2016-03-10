class SessionsController < ApplicationController

  def index
  end

  def new
  end

  def create
    auth = MeetupAuth.new
    response = auth.request_token(request.GET["code"])
    user_info = auth.request_user_info(response[:access_token])
    user = User.find_or_create_by_auth(response, user_info)
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
end
