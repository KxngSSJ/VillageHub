class ApplicationController < ActionController::Base
  # limits access to modern browsers (WebP, import maps, etc.)
  allow_browser versions: :modern

  # Makes the current_user method available in views as well as controllers
  helper_method :current_user

  # Returns the currently logged-in user (if any), using session[:user_id]
  def current_user
    # If @current_user is already set, use it; otherwise, look it up
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
