class SongsController < ApplicationController
  def show
    @song = Song.find_by id: params[:id]
    @song.count_views
    @lyric = Lyric.new
    @lyrics = @song.lyrics.is_accepted
    @lyric_item = @lyrics.first
    @recommends = Song.recommend @song.id
    @comment = Comment.new
    return if @song
    flash[:error] = t "flash.song_not_exits" + params[:id]
    redirect_to root_path
  end
end
