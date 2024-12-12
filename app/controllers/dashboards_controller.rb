class DashboardsController < ApplicationController
  layout "application_dashboard"
  skip_before_action :authenticate_user!, only: [:dashboard_pro]
  before_action :set_property, except: [:dashboard, :dashboard_pro]

  def dashboard
    @property = current_user.properties.last
    @property = Property.find(cookies[:property_id].to_i) if cookies[:property_id] != ""
    @property = Property.find(params[:property]) if params[:property]
    @marker = { lat: @property.latitude, lng: @property.longitude }
    cookies[:property_id] = @property.id
  end

  def documents
    @documents = @property.documents
    if params[:category]
      @documents = @property.documents.select {|doc| doc.document_category.name == params[:category]}
    end
  end

  def actions
  end

  def contacts
  end

  def calendar
    @items = @property.list_items
    @appointments = @property.appointments
    @actions = @property.work_actions
  end

  def lists
  end

  def settings
  end

  # LE FAIRE SUR UN AUTRE CONTROLLER ?! + CHANGER LE LAYOUT
  def dashboard_pro
    render layout: "application"
  end

  private

  def set_property
    if params[:property]
      @property = Property.find(params[:property])
    else
      @property = Property.find(cookies[:property_id]).to_i
    end
  end
end
