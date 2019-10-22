class TasksController < ApplicationController
  before_action :set_task, only: [:show,:edit]

  def index
    @tasks = Task.all
  end

  def show; end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.new(task_params)
  end

  private
  def set_task
  @task = Task.find(params[:id])
  end

  def task_params
  params.require(:task).permit(:task_name,:task_details)
  end

end
