class TasksController < ApplicationController
  before_action :set_task, only: [:show,:edit,:update,:destroy]

  def index
    @q = Task.ransack(params[:q])
    @tasks = @q.result(distinct: true).sorted
    @tasks = @tasks.page(params[:page])
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    if @task.save
    flash[:notice] = "タスクを作成しました"
    redirect_to task_path(@task.id)
    else
    flash[:notice] = "タスクの作成に失敗しました"
    render :new
    end
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
      flash[:notice] = "タスクの編集に失敗しました"
      render :edit
    end  
  end  

  private
  def set_task
  @task = Task.find(params[:id])
  end

  def task_params
  params.require(:task).permit(:name,:detail,:deadline,:priority,:status)
  end

  def search_params
  params.require(:q).permit(:name_cont)
  end 

end
