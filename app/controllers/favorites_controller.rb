class FavoritesController < ApplicationController

  def create
    @company = Company.find(params[:company_id])
    # gérer si plusieurs maisons
    # faire ça en JS / fetch
    current_user.properties.each do |property|
      Favorite.create!(company: @company, property: property)
    end

    if request.referer.include?(company_path(@company))
      redirect_to company_path(@company)
    else
      redirect_to companies_path
    end
  end


  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy

    if request.referer.include?(company_path(@favorite.company))
      redirect_to company_path(@favorite.company)
    else
      redirect_to companies_path
    end
  end
end
