class CategoriesController < ApplicationController
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

  def show

  end

  private

  def require_admin
    redirect_to log_in_path if !logged_in? || !current_user.admin?
  end

  def category_params
    params.require(:category).permit(:name)
  end
end