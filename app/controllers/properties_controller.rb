require 'open-uri'

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
    unless session[:property_id] != '' || session[:property_id].nil?
      render layout: 'application_dashboard'
    end
  end

  def create
    @property = Property.new(property_params)
    @property.user = current_user
    if @property.save
      redirect_to dashboard_path, notice: 'Propriété créée avec succès'
    else
      render :new,
             layout: 'application_dashboard',
             status: :unprocessable_entity
    end
  end

  def edit
    @property =
      Property.find(params[:id]) || Property.find(params[:Property_id])
    render layout: 'application_dashboard'
  end

  def update
    @property = Property.find(params[:id])
    if @property.update(property_params)
      redirect_to dashboard_path, notice: 'Propriété modifiée avec succès'
    else
      render :edit,
             layout: 'application_dashboard',
             status: :unprocessable_entity
    end
  end

  def destroy
    @property = Property.find(params[:id])
    @property.destroy
    redirect_to dashboard_path, notice: 'Propriété supprimée avec succès'
  end

  def generate_pdf
    @properties = Property.all
    @property = Property.find_by(name: "Maison Pottier")
    pdf = Prawn::Document.new
    pdf.text "Information: #{@property.name}", size: 18, style: :bold
    pdf.text "Description: #{@property.address}", size: 12

    @property.work_actions.each do |action|
      action.photos.each do |image|
        # REVOIR CET URL SI EN PROD
        # REVOIR CET URL EN METTANT LES INFOS CLOUDINARY DANS LE .ENV ET QUE CHACUN PUISSE LE CHANGER
        cloudinary_url = "https://res.cloudinary.com/dpkd2outh/image/upload/v1734110308/development/#{image.key}"
        begin
        image_file = URI.open(cloudinary_url)
        tempfile = Tempfile.new(['property_image', '.jpg'])
        tempfile.binmode
        tempfile.write(image_file.read)
        tempfile.rewind

        # Add the image to the PDF
        pdf.image tempfile.path, width: 200
        tempfile.close
        tempfile.unlink
        rescue OpenURI::HTTPError
          pdf.text "Image could not be loaded."
        end
      end

      pdf.start_new_page unless @property == @properties.last
    end

    # Send the PDF as a downloadable file
    send_data pdf.render,
              filename: "your_pdf.pdf",
              type: "application/pdf",
              disposition: "attachment"
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



     # test to get one photo from my cloudinary account
      # ca fonctionne ci dessous
      # cloudinary_url = "https://res.cloudinary.com/dpkd2outh/image/upload/v1734110308/development/e56nf14pj3h369ixovbug4yp852x.jpg"
      # begin
      #   image_file = URI.open(cloudinary_url)
      #   tempfile = Tempfile.new(['property_image', '.jpg'])
      #   tempfile.binmode
      #   tempfile.write(image_file.read)
      #   tempfile.rewind

      #   # Add the image to the PDF
      #   pdf.image tempfile.path, width: 200
      #   tempfile.close
      #   tempfile.unlink
      # rescue OpenURI::HTTPError
      #   pdf.text "Image could not be loaded."
      # end
