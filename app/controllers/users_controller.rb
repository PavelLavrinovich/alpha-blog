class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:new, :create]
  before_action :require_exact_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id if !logged_in? || !current_user.admin?
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @user.destroy
    flash[:notice] = 'The article has been deleted.'
    redirect_to users_path
  end

  private

  def require_exact_user
    redirect_to log_in_path if !logged_in? || (current_user != @user && !current_user.admin?)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end