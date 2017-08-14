class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def save_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
