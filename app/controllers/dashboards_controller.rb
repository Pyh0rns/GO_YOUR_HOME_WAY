class DashboardsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:dashboard_pro ]
  before_action :set_property, except: [:dashboard, :dashboard_pro]

  def dashboard
    @property = current_user.properties.last
    @property = Property.find(params[:property]) if params[:property]
    @marker = { lat: @property.latitude, lng: @property.longitude }
    cookies[:marker] = @marker.to_json
    render 'layout_dashboard', locals: {here: 'dashboard'}
  end

  def documents
    render 'layout_dashboard', locals: {here: 'documents'}
  end

  def actions
    render 'layout_dashboard', locals: {here: 'actions'}
  end

  def contacts
    render 'layout_dashboard', locals: {here: 'contacts'}
  end

  def calendar
    # start_date = params.fetch(:start_date, Date.today).to_date
    # @items = ListItem.where(deadline: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
    @items = @property.list_items
    @appointments = @property.appointments
    render 'layout_dashboard', locals: {here: 'calendar'}
  end

  def lists
    render 'layout_dashboard', locals: {here: 'lists'}
  end

  def settings
    render 'layout_dashboard', locals: {here: 'settings'}
  end


  # LE FAIRE SUR UN AUTRE CONTROLLER ?!
  def dashboard_pro


  end


  def set_property
    @property = Property.find(params[:property])
  end
end
