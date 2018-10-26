class Admin::AlbumsController < Admin::BaseController
  before_action :load_album, only: %i(update edit destroy)
  before_action :show_albums, only: %i(index destroy show)
  
  def index
  end

  def new
    @album = Album.new
    @artist = Artist.new
    @category = Category.new
  end

  def create
    @album = Album.new album_params
    if @album.save
      flash[:success] = "Succeed create Album"
    else
      flash[:danger] = "Failed create Album"
    end
    redirect_to admin_albums_path
  end

  def update
    if @album.update_attributes album_params
      flash[:success] = "Succeed update category"
    else
      flash[:danger] = "Failed update category"
    end
    redirect_to admin_albums_path
  end

  def show
  end

  def edit
    @artist = Artist.new
    @category = Category.new
  end

  def destroy
    @album.destroy
  end

  private

  def album_params
    params.require(:album).permit :name, :artist_id, :category_id
  end

  def load_album
    @album = Album.find_by id: params[:id]
    return if @album
    flash[:danger] = "Can't find this category with id: #{params[:id]}"
    redirect_to admin_albums_path
  end
  
  def show_albums
    @offset = params[:page] ? (params[:page].to_i - 1)*Settings.paginate.page : 0
    @albums = Album.order_album.search_by_name(params[:search])
      .page(params[:page]).per Settings.paginate.page
    respond_to do |format|
      format.html
      format.js
    end
  end
  
end
