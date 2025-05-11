class WorkPostsController < ApplicationController
  before_action :require_tradesman, only: [ :new, :create, :edit, :update ]
  before_action :set_work_post, only: [ :show, :edit, :update, :destroy ]

  # Show form to upload a new work post
  def new
    @work_post = WorkPost.new
  end

  # Handle submission of new work post
  def create
    @work_post = current_user.work_posts.build(work_post_params)
    if @work_post.save
      redirect_to @work_post, notice: "Work uploaded successfully!"
    else
      render :new
    end
  end

  # Show a single work post
  def show
  end

  # Show all posts
  def index
    @work_posts = WorkPost.includes(:user).all
  end

  # Show form to edit an existing post
  def edit
    unless @work_post.user == current_user
      redirect_to work_posts_path, alert: "You can only edit your own posts."
    end
  end

  # Handle update submission
  def update
    if @work_post.user == current_user
      if @work_post.update(work_post_params)
        redirect_to @work_post, notice: "Work post updated successfully."
      else
        render :edit
      end
    else
      redirect_to work_posts_path, alert: "You can only update your own posts."
    end
  end

  # Allow users to delete their own posts
  def destroy
    if @work_post.user == current_user
      @work_post.destroy
      redirect_to work_posts_path, notice: "Work post deleted successfully."
    else
      redirect_to work_posts_path, alert: "You can only delete your own posts."
    end
  end

  private

  def set_work_post
    @work_post = WorkPost.find(params[:id])
  end

  def work_post_params
    params.require(:work_post).permit(:title, :description, :image)
  end

  def require_tradesman
    unless current_user&.is_tradesman
      redirect_to root_path, alert: "Only tradesmen can perform this action."
    end
  end
end
