class Admin::UsersController < ApplicationController
  include SessionsHelper
  before_action :set_user, only: [:show,:edit,:update,:destroy]
  def index
    current_user
    @tasks = Task.all
    @users = User.all.paginate(page: params[:page], per_page: 10)
    @user = User.find(current_user.id)
  end
  def new
    @user = User.new
  end
  def show
    @q = Task.ransack(params[:q])
    @tasks = @q.result(distinct: true).where(user_id: @user.id).paginate(page: params[:page], per_page: 10)
  end
  def destroy
    if @user.destroy
      flash[:notice] = "ユーザーを削除しました"
      redirect_to admin_users_path
    else
      flash[:notice] = "管理者がいなくなるため削除できません"
      redirect_to admin_users_path
    end
  end
  def update
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to admin_users_path
    else
      flash.now[:notice] = "ユーザー情報の更新に失敗しました"
      render :edit
    end
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "新規登録しました"
      redirect_to admin_users_path
    else
      flash.now[:notice] = "登録に失敗しました"
      render :new
    end
  end
  def edit; end
  
  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:password_confirmation,:password,:name,:email,:admin_or_not)
  end
end
