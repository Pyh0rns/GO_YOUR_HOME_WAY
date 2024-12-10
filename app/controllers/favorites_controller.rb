class FavoritesController < ApplicationController

  def create
    @company = Company.find(params[:company_id])
    # gérer si plusieurs maisons
    # faire ça en JS / fetch
    current_user.properties.each do |property|
      Favorite.create!(company: @company, property: property)
    end

    redirect_to companies_path
  end


  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    redirect_to companies_path
  end
end
