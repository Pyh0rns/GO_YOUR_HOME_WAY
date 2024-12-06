class WorkActionsController < ApplicationController
  def new
    @property = Property.find(params[:property_id])
    @work_action = WorkAction.new
  end

  def create
    @property = Property.find(params[:property_id])
    @work_action = WorkAction.new(work_action_params)
    @work_action.property = @property
    @work_action.actionable = current_user if current_user
    @work_action.actionable = current_company if current_company

    if @work_action.save
      redirect_to dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def work_action_params
    params.require(:work_action).permit(:name, :description, :date, :action_category_id, photos: [])
  end
end
