class PasswordsController < ApplicationController
  def forgot
    # shows the forgot password form
  end

  def reset
    user = User.find_by(email: params[:email])

    if user
      user.update(password: params[:password])
      redirect_to login_path, notice: "Password reset successfully. Please log in."
    else
      flash.now[:alert] = "No user found with that email."
      render :forgot
    end
  end
end
