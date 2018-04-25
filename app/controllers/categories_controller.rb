class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :show, :update, :destroy]
  before_action :require_admin, except: [:index, :show]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @category.update(category_params)
      flash[:notice] = 'The category has been updated.'
      redirect_to category_path(@category)
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = 'The category has been deleted.'
    redirect_to categories_path
  end

  def show
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def require_admin
    redirect_to log_in_path if !logged_in? || !current_user.admin?
  end

  def category_params
    params.require(:category).permit(:name)
  end
end