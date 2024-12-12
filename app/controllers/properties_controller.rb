class PropertiesController < ApplicationController

  def index
    @properties = current_user.properties
    # render layout: "application_dashboard"
  end

  # def show
  #   @property = Property.find(params[:id])
  # end

  def new
    @property = Property.new
    unless session[:property_id] != "" || session[:property_id].nil?
      render layout: "application_dashboard"
    end
  end

  def create
    @property = Property.new(property_params)
    @property.user = current_user
    raise
    if @property.save
      redirect_to dashboard_path, notice: 'Propriété créée avec succès'
    else
      render :new, layout: "application_dashboard", status: :unprocessable_entity
    end
  end

  def edit
    @property = Property.find(params[:id]) || Property.find(params[:Property_id])
    render layout: "application_dashboard"
  end

  def update
    @property = Property.find(params[:id])
    if @property.update(property_params)
      redirect_to dashboard_path, notice: 'Propriété modifiée avec succès'
    else
      render :edit, layout: "application_dashboard", status: :unprocessable_entity
    end
  end

  def destroy
    @property = Property.find(params[:id])
    @property.destroy
    redirect_to dashboard_path, notice: 'Propriété supprimée avec succès'
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
        :property_category_id
      )
  end
end
