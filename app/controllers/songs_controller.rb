class SongsController < ApplicationController
  before_action :load_song, only: :show
  before_action :not_recommend_song, only: :show

  def show
    @lyric = Lyric.new
    @comment = Comment.new
    @favorite_list = FavoriteList.new
    @song.count_views
    @lyrics = @song.lyrics.is_accepted
    @lyric_item = @lyrics[Settings.index.first_item]
    session[:not_recommend] << @song.id unless session[:not_recommend].include?(@song.id)
    @recommends = Song.recommend session[:not_recommend]
    @avg_rating = Rating.avg_rating @song.id, @song.class.name
    @comments = Comment.find_comment(@song.id, :Song).order_created_at.
      page(params[:page]).per Settings.paginate.page
    if current_user
      @favorite_lists = current_user.favorite_lists
    end
    respond_to do |format|
      format.html
      format.js {render layout: false}
    end
  end
  
  def next
    @next_song = NextSong.new params[:song_id], params[:album_id],
      params[:favorite_list_id]
    @song = @next_song.next_song
    return if @song.nil?
    @lyrics = @song.lyrics.is_accepted
    @lyric_item = @lyrics.first
    if current_user
      @favorite_lists = current_user.favorite_lists
    end
    respond_to do |format|
      format.js
    end
  end
  
  def audio_download
    @song = Song.find(params[:id])
    send_file @song.audio.path, :filename => @song.audio_file_name,
      :type => @song.audio_content_type, :disposition => "attachment"
  end

  private
  
  def load_song
    @song = Song.find_by id: params[:id]
    return if @song
    flash[:danger] = t("flash.song_not_exits") + params[:id]
    redirect_to root_path
  end
  
  def not_recommend_song
    return if session[:not_recommend]
    session[:not_recommend] = []
  end
end
