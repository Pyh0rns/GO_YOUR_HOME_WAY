class WorkActionsController < ApplicationController
  def new
    @property = Property.find(params[:property_id])
    @work_action = WorkAction.new
    render layout: "application_dashboard"

  end

  def create
    @property = Property.find(params[:property_id])

    if params[:work_action][:actionable_id].nil? || params[:work_action][:actionable_id].empty?
      @work_action = @property.work_actions.new(work_action_params)
      @work_action.actionable = current_user
    elsif params[:work_action][:actionable_id]
      @company = Company.find(params[:work_action][:actionable_id])
      @work_action = @property.work_actions.new(work_action_params)
      @work_action.actionable = @company
    end

    if @work_action.save
      redirect_to actions_path(property: @work_action.property)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def work_action_params
    params.require(:work_action).permit(:name, :description, :date, :actionable_id, :action_category_id, photos: [])
  end
end
