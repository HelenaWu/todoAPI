class Api::ItemsController < ApiController
  before_action :authenticated?

  def create
    list = List.find(params[:list_id])

    item = list.items.create(item_params)
    if item.persisted?
      render json: item
    else
      render json: {errors: item.errors.full_messages}, status: :unprocessible_entity
    end
  end

  def update
    begin
      item = Item.find(params[:id])      
      if item.update(item_params)
        render json: item
      else
        render json: {errors: item.errors.full_messages}, status: :unprocessible_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: {errors: "item not found"}, status: :not_found
    end
  end


  private
  def item_params
    params.require(:item).permit(:description, :status)
  end
end
