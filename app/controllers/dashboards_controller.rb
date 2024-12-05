class DashboardsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :dashboard_pro ]


  def dashboard
    @property = current_user.properties.last
    @property = Property.find(params[:property]) if params[:property]
  end




  def dashboard_pro

  end
end
