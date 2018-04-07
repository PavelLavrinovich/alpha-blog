class SessionsController < ApplicationController
  def new

  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    user = User.find_by(email: email)
    if user && user.authenticate(password)
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash.now[:danger] = 'Something wrong with your login information'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end