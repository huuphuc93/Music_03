class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(edit update destroy)
  before_action :correct_user, except: %i(index create new)

  def new
    @user = User.new
  end

  def show
    @favorite_lists = @user.favorite_lists.page(params[:page])
      .per Settings.paginate.page
  end
  
  def create
    @user = User.new_with_session user_params, session
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = t "flash.check_email"
      redirect_to root_url
      session[:user_attributes] = []
    else
      render :new
    end
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "flash.profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "flash.user_deleted"
    else
      flash[:danger] = t "flash.user_delete_failed"
    end
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def correct_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "flash.user_dont_exit"
    redirect_to root_url
  end
end
