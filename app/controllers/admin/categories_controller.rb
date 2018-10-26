class Admin::CategoriesController < Admin::BaseController
  before_action :load_category, only: %i(update edit destroy)
  before_action :show_categories, only: %i(index destroy show)

  def index
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "flash.create_category_succeed"
    else
      flash[:danger] = t "flash.create_category_failed"
    end
    respond_to do |format|
      format.html {redirect_to admin_categories_path}
      format.js
    end
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "flash.update_category_succeed"
    else
      flash[:danger] = t "flash.update_category_failed"
      redirect_to edit_admin_categorie_path
    end
    redirect_to admin_categories_path
  end

  def destroy
    @category.destroy
  end

  private

  def category_params
    params.require(:category).permit :name
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t("flash.category_not_exits") + params[:id]
    redirect_to admin_categories_path
  end
  
    def show_categories
      @offset = offset_value params[:page]
      @categories = Category.order_name.search_by_name(params[:search])
      .page(params[:page]).per Settings.paginate.page
      respond_to do |format|
        format.html
        format.js
      end
    end
end