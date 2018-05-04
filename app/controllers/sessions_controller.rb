class SessionsController < ApplicationController
  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      check_user_activated user, params[:session][:remember_me]
    else
      flash.now[:danger] = t "flash.invalid_email"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
