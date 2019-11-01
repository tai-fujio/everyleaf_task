class ApplicationController < ActionController::Base
  helper_method :current_user, :log_in?
  before_action :login_must

  private
  def login_must
    unless current_user
      redirect_to root_path
    end
  end    
end
