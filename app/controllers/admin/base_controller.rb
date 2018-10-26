class Admin::BaseController < ApplicationController
  layout "admin/layouts/application"
  before_action :logged_in_user, :check_admin

  def offset_value page
    return Settings.offset.first_page unless page
    (page.to_i - Settings.offset.sub_page)*Settings.paginate.page
  end
  
  private

  def check_admin
    return if current_user.admin?
    flash[:danger] = t "flash.permission_denied"
    redirect_to root_path
  end
end
