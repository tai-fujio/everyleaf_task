class UsersController < ApplicationController
  skip_before_action :must_login
  before_action :must_not_login
  include SessionsHelper
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "新規登録しました<br>ログインしました"
      session[:user_id] = @user.id
      redirect_to tasks_path(user_id: @user.id)
    else
      flash.now[:notice] = "登録に失敗しました"
      render :new
    end
  end
  private
  def user_params
    params.require(:user).permit(:password_confirmation,:password,:name,:email,:admin_or_not)
  end  
end
