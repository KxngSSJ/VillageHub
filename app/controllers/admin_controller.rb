class AdminController < ApplicationController
  # check that the user is an admin.
  before_action :require_admin

  # This is the main admin dashboard action.
  # It loads all users and all work posts so the admin can manage them.
  def dashboard
    @users = User.all
    @work_posts = WorkPost.all

    # Additional stats for the admin dashboard
    @total_users = @users.count                                  # Total number of users registered
    @tradesmen_count = @users.where(is_tradesman: true).count    # Number of users marked as tradesmen
    @non_tradesmen_count = @users.where(is_tradesman: false).count # Number of users who are not tradesmen
    @admin_count = @users.where(is_admin: true).count            # Number of admin users
    @total_posts = @work_posts.count                             # Total number of work posts
    @average_ratings = Rating.average(:score)&.round(2) || 0     # Average rating given across all posts
  end

  private

  # This method makes sure that only admin users can access the dashboard
  def require_admin
    # Look up the currently logged-in user using their session ID
    user = User.find_by(id: session[:user_id])

    # If there is no user or the user is not an admin, redirect them away
    unless user&.is_admin
      redirect_to root_path, alert: "Access denied."
    end
  end
end
