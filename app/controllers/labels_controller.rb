class LabelsController < ApplicationController
  include SessionsHelper
  # def create
  #   current_user
  #   current_user.labels.create(label_params)
  # end
  # def destroy
  #   current_user.labels.destroy(:id params[:task_id])
  # end
  # private
  # def label_params
  #   params.require(:label).permit(:task_id,:name,label_ids:[])
  # end
end
