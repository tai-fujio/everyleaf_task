module UsersHelper
  def must_login_user
    unless current_user && (@user.id == current_user.id)
      flash[:notice] = "権限がありません"
      redirect_to tasks_path(id: current_user.id)
    end
  end
end
