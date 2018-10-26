class FavoriteListsController < ApplicationController
  before_action :load_favorite_list, only: %i(show destroy)
  before_action :not_recommend_fl, only: :show

  def create
    if logged_in?
      @favorite_list = FavoriteList.new name: params[:favorite_list][:name]
      @favorite_list.user = current_user
      @favorite_list.save
      @song= Song.find_by id: params[:favorite_list][:song_id]
    end
    respond_to do |format|
      format.js
    end
  end
  
  def show
    @favorite_list.count_views
    @avg_rating = Rating.avg_rating @favorite_list.id, :FavoriteList
    @song = @favorite_list.songs[Settings.index.first_item]
    @comment = Comment.new
    @comments = Comment.find_comment(@favorite_list.id, :FavoriteList).
      order_created_at.page(params[:page]).per Settings.paginate.page
    if current_user
      @favorite_lists = current_user.favorite_lists
    end
    session[:not_recommend_fl] << @favorite_list.id unless session[:not_recommend_fl].include?(@favorite_list.id)
    @recommends = FavoriteList.recommend session[:not_recommend_fl]
    return unless @user
    @lyrics = @song.lyrics.is_accepted
    @lyric_item = @lyrics[Settings.index.first_item]
  end

  def destroy
    user = @favorite_list.user
    if @favorite_list.destroy
      flash[:success] = t "flash.delete_favorite_list_succeed"
    else
      flash[:danger] = t "flash.delete_favorite_list_failed"
    end
    redirect_to user_path(user)
  end
  
  def load_favorite_list
    @favorite_list = FavoriteList.find_by id: params[:id]
    return if @favorite_list
    flash[:danger] = t("flash.favorite_list_not_exits") + params[:id]
  end
  
  def not_recommend_fl
    return if session[:not_recommend_fl]
    session[:not_recommend_fl] = []
  end
end
