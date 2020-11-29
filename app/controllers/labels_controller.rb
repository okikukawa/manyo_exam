class LabelsController < ApplicationController
  def new
    @label = Lavel.new
  end
  def create

  end
  def destroy

  end
  private
  def label_params
    params.require(:label).permit(:name)
  end
end
