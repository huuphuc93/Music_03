module UserHelper
  def activate_user user
    user.activated? ? t("views.admin.users.index.activated") : t("views.admin.users.index.not_activated")
  end
end
