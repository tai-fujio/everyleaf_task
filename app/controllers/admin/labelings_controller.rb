class Admin::LabelingsController < ApplicationController
  def new
    @labelings = Labeling.all
    @labeling = Labeling.new
  end
  def create
    @labelings = Labeling.all
    @labeling = Labeling.new(labeling_params)
    if @labeling.valid?
      @labeling.save
      flash[:notice] = "タスクタイプを新規作成しました"
      redirect_to new_admin_labeling_path
    else
      flash.now[:notice] = "タスクタイプの新規作成に失敗しました"
      render :new
    end
  end
  def destroy
    @labeling = Labeling.find(params[:id])
    @labeling.destroy
    flash[:notice] = "タスクタイプを削除しました"
    redirect_to new_admin_labeling_path
  end
  private
  def labeling_params
    params.require(:labeling).permit(:name)
  end  
end
