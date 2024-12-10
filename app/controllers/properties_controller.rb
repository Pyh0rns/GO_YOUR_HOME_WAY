class PropertiesController < ApplicationController
  def index
    @properties = current_user.properties
  end

  def show
    @property = Property.find(params[:id])
  end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)
    @property.user = current_user
    if @property.save
      redirect_to dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @property = Property.find(params[:id])
  end

  def update
    @property = Property.find(params[:id])
    if @property.update(property_params)
      redirect_to dashboard_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @property = Property.find(params[:id])
    @property.destroy
    redirect_to dashboard_path
  end

  private

  def property_params
    params
      .require(:property)
      .permit(
        :name,
        :address,
        :buying_price,
        :buying_date,
        :fee_price,
        :surface,
        :number_of_rooms,
      )
  end
end
