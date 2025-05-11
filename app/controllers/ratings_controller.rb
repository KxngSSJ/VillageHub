class RatingsController < ApplicationController
  def create
    @work_post = WorkPost.find(params[:work_post_id])
    @rating = @work_post.ratings.build(score: params[:score], user: current_user)

    if @rating.save
      redirect_to work_posts_path, notice: "Thanks for rating!"
    else
      redirect_to work_posts_path, alert: "Something went wrong."
    end
  end
end
