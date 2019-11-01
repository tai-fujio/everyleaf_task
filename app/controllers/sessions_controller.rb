class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(params[:session][:email].downcase)
    # user = User.find_by(email: session_params[:email])
    # if user&.authenticate(session_params[:password]) 
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to users_path
    else
      flash[:notice] = "ログインに失敗しました"
      render :new
    end  
  end
end
