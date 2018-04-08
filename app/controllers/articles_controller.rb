class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :show, :update, :destroy]
  before_action :autorize

  def new
    @article = Article.new
  end

  def edit

  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def create
    @article = Article.new(article_params)
    @article.user = User.find(session[:user_id])
    if @article.save
      flash[:notice] = 'The article has been created.'
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = 'The article has been updated.'
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def show

  end

  def destroy
    @article.destroy
    flash[:notice] = 'The article has been deleted.'
    redirect_to articles_path
  end

  private

  def autorize
    redirect_to log_in_path unless session[:user_id]
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
end