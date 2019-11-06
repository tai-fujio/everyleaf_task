class LabelsController < ApplicationController
  include SessionsHelper
  def create
    current_user
    current_user.labels.create(:labeling_id params[:labeling.id])
  end
  def destroy
    current_user.labels.destroy(:id params[:task_id])
  end
end
