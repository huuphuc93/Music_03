class Admin::SongsController < Admin::BaseController
  before_action :load_song, only: %i(update edit destroy)
  before_action :show_songs, only: %i(index destroy show)
  def index
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new song_params
    if @song.save
      flash[:success] = "Succeed Create category"
      SendEmailJob.set(wait: 20.seconds).perform_later(@song)
      redirect_to admin_songs_path
    else
      render :new
    end

  end

  def update
    hot_song = params[:song][:accepted] == "0" ? false : true
    update_hotsong hot_song
    if @song.update_attributes song_params
      flash[:success] = "Succeed update category"
    else
      flash[:danger] = "Failed update category"
      render :edit
    end
    redirect_to admin_songs_path
  end

  def destroy
    @song.destroy
  end

  private

  def song_params
    params.require(:song).permit :name, :album_id, :audio, :cover_image,
      :hot_song
  end

  def update_hotsong accepted
    @song.update_attributes hot_song: accepted
  end

  def load_song
    @song = Song.find_by id: params[:id]
    return if @song
    flash[:danger] = "Can't find this Song with id: #{params[:id]}"
    redirect_to admin_songs_path
  end

  def show_songs
    @offset = params[:page] ? (params[:page].to_i - 1)*Settings.paginate.page : 0
    @songs = Song.order_song.search_by_name(params[:search])
      .page(params[:page]).per Settings.paginate.page
    respond_to do |format|
      format.html
      format.js
    end
  end
end
