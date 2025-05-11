class UsersController < ApplicationController
  #  method to  show, edit, update, destroy
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to login_path, notice: "Account created successfully! Please log in."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # Already handled by set_user
  end

  def edit
    # Shows the edit form
  end

  def update
    if @user.update(user_params)
      redirect_to admin_dashboard_path, notice: "User updated successfully."
    else
      render :edit
    end
  end

  private

  # Finds the user for show/edit/update
  def set_user
    @user = User.find(params[:id])
  end

  # Allows safe parameter updates
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :is_tradesman, :role)
  end
end
