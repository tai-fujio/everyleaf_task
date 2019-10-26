class TasksController < ApplicationController
  before_action :set_task, only: [:show,:edit,:update,:destroy]

  def index
    @tasks = Task.all
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    flash[:notice] = "タスクを作成しました"
    redirect_to task_path(@task.id)
  end  

  def destroy
    @task.destroy
    flash[:notice] = "タスクを削除しました"
    redirect_to tasks_path
  end  

  def edit; end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = "タスクを編集しました"
      redirect_to tasks_path
    else 
      render :edit
    end  
  end  

  private
  def set_task
  @task = Task.find(params[:id])
  end

  def task_params
  params.require(:task).permit(:task_name,:task_details)
  end

end
