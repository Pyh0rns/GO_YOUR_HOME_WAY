class AppointmentsController < ApplicationController
  def new
    @property = Property.find(params[:property_id])
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.property = Property.find(params[:property_id])

    # si la company n'est pas déjà dans mes favs, je l'ajoute
    unless @appointment.property.favorites.exists?(company: @appointment.company)
      Favorite.create!(property: Property.find(params[:property_id]), company: @appointment.company )
    end

    if @appointment.save
      redirect_to calendar_path(property: @appointment.property)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    redirect_to calendar_path(property: @appointment.property)
  end

  def appointment_params
    params.require(:appointment).permit(:company_id, :description, :date)
  end
end
