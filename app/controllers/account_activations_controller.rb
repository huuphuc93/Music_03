class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_attributes(activated: true)
      user.update_attributes(activated_at: Time.zone.now)
      log_in user
      flash[:success] = t "flash.account_activated"
      redirect_to user
    else
      flash[:danger] = t "flash.invalid_activation"
      redirect_to root_url
    end
  end
end
