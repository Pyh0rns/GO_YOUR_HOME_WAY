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

  def actions
    @property = Property.find(params[:property])
    render 'layout_dashboard', locals: {here: 'actions'}
  end

  def contacts
    @property = Property.find(params[:property])
    render 'layout_dashboard', locals: {here: 'contacts'}
  end

  def calendar
    @property = Property.find(params[:property])
    render 'layout_dashboard', locals: {here: 'calendar'}
  end



  # LE FAIRE SUR UN AUTRE CONTROLLER ?!
  def dashboard_pro


  end
end
