class CompaniesController < ApplicationController
  def index
    @companies = Company.all
    @companies = Company.search(params[:query]) if params[:query].present?
  end

  def show
    @company = Company.find(params[:id])
    @marker = { lat: @company.latitude, lng: @company.longitude }
  end
end
