class WorkActionsController < ApplicationController
  def new
    @property = Property.find(params[:property_id])
    @action = WorkAction.new
  end

  def create
    @property = Property.find(params[:property_id])
    @action = WorkAction.new(action_params)
    # @action.actionable = current_user if current_user
    # @action.actionable = current_company if current_company

    @action.property = @property

    if @action.save
      redirect_to dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def action_params

    # params.require(:action).permit(:name, :description, :date, :action_category_id)
    params.require(:action).permit(:name)
  end
end
