class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
    @marker = {
      lat: @company.latitude,
      lng: @company.longitude
    }
  end
end
