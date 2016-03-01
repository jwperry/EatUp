class SessionsController < ApplicationController
  before_action :set_mock if Rails.env.test?

  def new
  end

  def create
    binding.pry
    user = User.find_or_create_by_auth(username: params[:session][:username])

    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
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
