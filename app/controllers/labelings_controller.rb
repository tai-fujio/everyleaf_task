class LabelingsController < ApplicationController
  def new
    @labelings = Labeling.all
    @labeling = Labeling.new
  end

  def create
    @labeling = Labeling.new(labeling_params)
  end  
  
  private
  def labeling_params
    params.require(:labeling).permit(:name)
  end  
end
