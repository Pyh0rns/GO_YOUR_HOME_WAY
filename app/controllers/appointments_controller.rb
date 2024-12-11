class AppointmentsController < ApplicationController
  def new
    @property = Property.find(params[:property_id])
    @appointment = Appointment.new
  end

  def create
    @property = Property.find(params[:property_id])
    @appointment = Appointment.new(appointment_params)
    @appointment.property = @property
    if @appointment.save
      redirect_to dashboard_calendar_path(property: @appointment.property)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def appointment_params
    params.require(:appointment).permit(:company_id, :description, :date)
  end
end
