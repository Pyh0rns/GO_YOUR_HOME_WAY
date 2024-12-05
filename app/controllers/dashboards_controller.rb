class DashboardsController < ApplicationController

  def dashboard
    @property = current_user.properties.last

    if params[:property]
      @property = Property.find(params[:property])
    end
  end
end
