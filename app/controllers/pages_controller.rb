class PagesController < ApplicationController
  def home
    @hot_songs = Song.hot_song
    @songs = Song.order_song.limit Settings.limit.song
    @albums = Album.hot_albums.limit Settings.limit.album
    @favorite_lists = FavoriteList.recommend session[:not_recommend_fl]
  end
end
