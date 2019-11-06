class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :must_login

  private
  def must_login
    redirect_to new_session_path unless current_user
  end
  def must_not_login
    redirect_to tasks_path(id: current_user.id) if current_user
  end
  def must_admin
    unless current_user && (User.find(@current_user.id).admin_or_not == true)
      flash[:notice] = "権限がありません"
      redirect_to tasks_path(id: current_user.id)
    end
  end
end
