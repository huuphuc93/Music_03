class FavoritesController < ApplicationController
  before_action :load_favorite, only: :destroy

  def create
    @favorite = Favorite.new favorite_list_id: params[:favorite_list_id],
      song_id: params[:song_id]
    @favorite_list = FavoriteList.find_by id: params[:favorite_list_id]
    @song = Song.find_by id: params[:song_id]
    @favorite.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @favorite_list = @favorite.favorite_list
    @song = @favorite.song
    @favorite.destroy
    respond_to do |format|
      format.js
    end
  end
  
  private
  
  def load_favorite
    @favorite = Favorite.find_by id: params[:id]
    return if @favorite
    flash[:danger] = t("flash.favorite_not_exits") + params[:id]
    redirect_to root_path
  end
end
