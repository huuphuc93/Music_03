class SessionsController < ApplicationController
  def create
    user = User.find_by email: session_params[:email].downcase
    return if user && user.authenticate(session_params[:password])
      check_user_activated user, session_params[:remember_me]
      flash.now[:danger] = t "flash.invalid_email"
      render :new
  end

  def destroy
    log_out
    redirect_to root_path
  end
  
  private
  
  def session_params
    params.require(:session).permit :email, :password, :remember_me
  end
end
