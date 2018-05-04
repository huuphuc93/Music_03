class OmniauthCallbacksController < ApplicationController
  
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      log_in @user 
      flash[:success] = t "flash.login_success"
      redirect_to root_path
    else
      session["user_attributes"] = @user.attributes
      redirect_to signup_path
    end
  end
end
