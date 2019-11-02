class SessionsController < ApplicationController
  def new; end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to tasks_path
    else
      flash[:notice] = "ログインに失敗しました"
      render :new
    end
  end
  def destroy
    reset_session
    flash[:notice] = "ログアウトしました"
    redirect_to root_path
  end
end
