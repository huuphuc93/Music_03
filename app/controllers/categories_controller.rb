class CategoriesController < ApplicationController
  before_action :load_category, only: :show
  
  def show
    @albums = @category.albums.select_albums.page(params[:page])
      .per Settings.paginate.paginate_album
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  private

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t("flash.category_not_exits") + params[:id]
    redirect_to root_path
  end
end
