class LyricsController < ApplicationController
  before_action :logged_in_user, only: :create
  before_action :load_variable, only: [:next, :previus]
  
  def create
    @lyric = Lyric.new lyric_params
    @lyric.song_id = params[:song_id]
    @lyric.user = current_user
    if @lyric.save
      respond_to do |format|
        format.js
      end
    end
  end
  
  def next
    @lyric_new_item = @lyrics[@index + 1]
    respond_to do |format|
      format.js
    end
  end

  def previus
    @lyric_new_item = @lyrics[@index - 1]
    respond_to do |format|
      format.js
    end
  end
  
  private
  
  def lyric_params
    params.require(:lyric).permit :content
  end
  
  def load_variable
    @item = Lyric.find_by id: params[:lyric_id]
    @song = @item.song
    @lyrics = @song.lyrics.is_accepted
    @index = @lyrics.index @item
  end
end
