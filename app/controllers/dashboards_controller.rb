class DashboardsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :dashboard_pro ]


  def dashboard
    @property = current_user.properties.last
    @property = Property.find(params[:property]) if params[:property]
    render 'layout_dashboard', locals: {here: 'dashboard'}
  end

  def documents
    @property = Property.find(params[:property])
    render 'layout_dashboard', locals: {here: 'documents'}
  end




  def dashboard_pro

  end
end
