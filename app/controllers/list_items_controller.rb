class ListItemsController < ApplicationController

  def new
    @property = Property.find(params[:property_id])
    @item = ListItem.new
  end

  def create
    @property = Property.find(params[:property_id])
    @item = ListItem.new(item_params)
    @item.property = @property
    if @item.save
      redirect_to calendar_path(property: @item.property)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @item = ListItem.find(params[:id])
    @item.destroy
    redirect_to calendar_path(property: @item.property)
  end

  def item_params
    params.require(:list_item).permit(:title, :deadline)
  end
end
