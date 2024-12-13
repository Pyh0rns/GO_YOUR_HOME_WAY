class CompaniesController < ApplicationController
  def index
    @companies = Company.all
    @companies = Company.search(params[:query]) if params[:query].present?
    @property = session[:property_id]
    render layout: "application_dashboard"
  end

  def show
    @company = Company.find(params[:id])
    @marker = { lat: @company.latitude, lng: @company.longitude }
    @property = session[:property_id]
    render layout: "application_dashboard"
  end
end
