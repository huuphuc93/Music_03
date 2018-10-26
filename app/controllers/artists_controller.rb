class ArtistsController < ApplicationController
  before_action :load_artist, only: :show
  
  def show
    @songs = @artist.songs.page(params[:songs]).per Settings.paginate.page
    @albums = @artist.albums.includes(:category).page(params[:albums]).per Settings.paginate.page
    respond_to  do |format|
      format.html
      format.js
    end
  end
  
  private
  
  def load_artist
    @artist = Artist.find_by id: params[:id]
    return if @artist
    flash[:danger] = t("flash.artist_not_exits") + params[:id]
  end
end
