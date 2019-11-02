class Admin::UsersController < ApplicationController
  def index
    @tasks = Task.all
    @users = User.all.paginate(page: params[:page], per_page: 10)
  end
  def new; end
  def show; end
  def destroy
    @user = User.find(params[:id])
    @users = User.all
    if @user.admin? == false || @users.where(admin?: true).count > 1
      @user.destroy
      flash[:notice] = "ユーザーを削除しました"
      redirect_to admin_users_path
    else
      flash[:notice] = "管理者がいなくなるため削除できません"
      redirect_to admin_users_path
    end
  end
  def update; end
  def create; end
  def edit; end
end
