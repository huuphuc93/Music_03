class Admin::LyricsController < Admin::BaseController
  before_action :load_lyric, only: %i(update edit destroy)
  before_action :show_lyrics, only: %i(index destroy show)
  
  def index
  end

  def update
    accepted = params[:lyric][:accepted] == "0" ? false : true
    update_accepted accepted
    if @lyric.update_attributes! lyric_params
      flash[:success] = "Succeed update user"
    else
      flash[:error] = "Failed update user"
    end
    redirect_to admin_lyrics_path
  end

  def edit
  end

  def destroy
    @lyric.destroy
  end

  private

  def lyric_params
    params.require(:lyric).permit :content, :song_id, :user_id
  end

  def update_accepted accepted
    @lyric.update_attributes accepted: accepted
  end

  def load_lyric
    @lyric = Lyric.find_by id: params[:id]
    return if @lyric
    redirect_to admin_lyrics_path
    flash[:danger] = "Can't find user with id: #{params[:id]}"
  end
  
  def show_lyrics
    @offset = params[:page] ? (params[:page].to_i - 1)*Settings.paginate.page : 0
    @lyrics = Lyric.order_name.search_by_name(params[:search])
      .page(params[:page]).per Settings.paginate.page
    respond_to do |format|
      format.html
      format.js
    end
  end
  
end
