class DashboardsController < ApplicationController

  def dashboard
    @property = current_user.properties.last
    @property = Property.find(params[:property]) if params[:property]
  end
end
