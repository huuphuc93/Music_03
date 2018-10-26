class Admin::UsersController < Admin::BaseController
  before_action :load_user, only: %i(edit update destroy)
  before_action :show_users, only: %i(index destroy show)

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "flash.create_user_succeed"
    else
      flash[:danger] = t "flash.create_user_failed"
    end
    redirect_to admin_users_path
  end

  def update
    activated = params[:user][:activated] == Settings.activated.to_s ? false : true
    update_activated activated
    if @user.update_attributes user_params
      flash[:success] = t "flash.update_user_succeed"
    else
      flash[:error] = t "flash.update_user_failed"
      render :edit
    end
    redirect_to admin_users_path
  end

  def show
  end

  def destroy
    @user.destroy
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def update_activated activated
    @user.update_attributes activated: activated
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    redirect_to admin_users_path
    flash[:danger] = t "flash.user_dont_exit"
  end
  
  def show_users
    @offset = params[:page] ? (params[:page].to_i - 1)*Settings.paginate.page : 0
    @users = User.order_user.search_by_name(params[:search]).
      page(params[:page]).per Settings.paginate.page
    respond_to do |format|
      format.html
      format.js
    end
  end
end
