class SessionsController < ApplicationController
  skip_before_action :must_login
  def new; end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
    session[:user_id] = user.id
    flash[:notice] = "ログインしました"
    redirect_to tasks_path
    else
      flash.now[:notice] = "ログインに失敗しました"
      render :new
    end
  end
  def destroy
    reset_session
    flash[:notice] = "ログアウトしました"
    redirect_to root_path
  end
end
