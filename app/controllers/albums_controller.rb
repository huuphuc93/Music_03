class AlbumsController < ApplicationController
  before_action :load_album, only: :show
  before_action :not_recommend_album, only: :show
  
  def show
    @album.count_views
    @song = @album.songs[Settings.index.first_item]
    @avg_rating = Rating.avg_rating @album.id, :Album
    @lyrics = @song.lyrics.is_accepted
    @lyric_item = @lyrics[Settings.index.first_item]
    @favorite_list = FavoriteList.new
    @comment = Comment.new
    @comments = Comment.find_comment(@album.id, :Album).order_created_at.
      page(params[:page]).per Settings.paginate.page
    if current_user
      @favorite_lists = current_user.favorite_lists
    end
    session[:not_recommend_album] << @album.id unless session[:not_recommend_album].include?(@album.id)
    @recommends = Album.recommend session[:not_recommend_album]
  end
  
  private
  
  def load_album
    @album = Album.find_by id: params[:id]
    return if @album
    flash[:danger] = t("flash.album_not_exits") + params[:id]
    redirect_to root_path
  end
  
  def not_recommend_album
    return if session[:not_recommend_album]
    session[:not_recommend_album] = []
  end
end
