class ApplicationController < ActionController::Base
  include SessionsHelper
  # before_action :login_must

  private
  def login_must
    binding.pry
    unless current_user
      redirect_to root_path
    end
  end    
end
