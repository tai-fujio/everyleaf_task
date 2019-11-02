module SessionsHelper
  def current_user
    @current_user ||= User.find_by(:id params[:user_id])
  end
  def log_in?
    current_user.present?
  end
end
