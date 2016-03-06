class SessionsController < ApplicationController
  before_action :set_mock if Rails.env.test?

  def index
  end

  def new
  end

  def create
    response = request_token(request.GET["code"])
    user_info = request_user_info(response[:access_token])
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

  private

  def set_mock
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:meetup]
  end

  def request_token(code)
    conn = Faraday.new(url: "https://secure.meetup.com/oauth2/access") do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.request :url_encoded
      faraday.params[:code] = code
      faraday.params[:client_id] = ENV["MEETUP_CONSUMER_KEY"]
      faraday.params[:client_secret] = ENV["MEETUP_CONSUMER_SECRET"]
      faraday.params[:grant_type] = "authorization_code"
      faraday.params[:redirect_uri] = "#{ENV['HOST']}/login"
    end
    JSON.parse(conn.post("https://secure.meetup.com/oauth2/access").body, symbolize_names: true)
  end

  def request_user_info(token)
    conn = Faraday.new(url: "https://api.meetup.com") do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.params[:key] = ENV["MEETUP_API_KEY"]
      faraday.params[:sign] = "true"
      faraday.params[:access_token] = token
    end
    response = JSON.parse(conn.get("/members/self").body, symbolize_names: true)
  end
end
