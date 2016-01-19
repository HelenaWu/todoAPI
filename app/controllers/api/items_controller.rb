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

  def destroy
    
  end

  private
  def item_params
    params.require(:item).permit(:description)
  end
end
