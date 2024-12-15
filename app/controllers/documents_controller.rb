class DocumentsController < ApplicationController
  def new
    @property = Property.find(params[:property_id])
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    @property = Property.find(params[:property_id])
    @document.property = @property
    if @document.save
      redirect_to documents_path(property: @document.property)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def document_params
    params.require(:document).permit(:name, :description, :date, :document_category_id, :photo)
  end
end
