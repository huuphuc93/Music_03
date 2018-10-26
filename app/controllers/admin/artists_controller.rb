class Admin::ArtistsController < Admin::BaseController
  before_action :load_artist, only: %i(update edit destroy)
  before_action :show_artists, only: %i(index destroy show)

  def index
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new artist_params
    if @artist.save
      flash[:success] = "Succeed create artist"
    else
      flash[:error] = "Failed create artist"
    end
    respond_to do |format|
      format.html {redirect_to admin_artists_path}
      format.js
    end
  end

  def update
    if @artist.update_attributes artist_params
      flash[:success] = "Succeed update category"
    else
      flash[:error] = "Failed update category"
    end
    redirect_to admin_artists_path
  end

  def edit
  end

  def destroy
    @artist.destroy
  end

  private

  def artist_params
    params.require(:artist).permit :name
  end

  def load_artist
    @artist = Artist.find_by id: params[:id]
    return if @artist
    flash[danger] = "Can't find this category with id: #{params[:id]}"
    redirect_to admin_artists_path
  end
  
    def show_artists
      @offset = params[:page] ? (params[:page].to_i - 1)*Settings.paginate.page : 0
      @artists = Artist.order_artist.search_by_name(params[:search])
        .page(params[:page]).per Settings.paginate.page
      respond_to do |format|
        format.html
        format.js
      end
    end
end
