class Api::ItemsController < ApiController
  before_action :authenticated?

  def index
    items = Item.all
    render json: items, each_serializer: ItemSerializer
  end

  def create
    list = List.find(params[:list_id])
    if current_user.lists.include?(list)
      item = list.items.create(item_params)
      if item.persisted?
        render json: item
      else
        render json: {errors: item.errors.full_messages}, status: :unprocessible_entity
      end
    else
      render json: {errors: "Can't modify another user's list"}, status: :unprocessible_entity
    end
  end

  def update
    begin
      list = List.find(params[:list_id])
      if current_user.lists.include?(list)
        item = Item.find(params[:id])      
        if item.update(item_params)
          render json: item
        else
          render json: {errors: item.errors.full_messages}, status: :unprocessible_entity
        end
      else
        render json: {errors: "Can't modify another user's list"}, status: :unprocessible_entity
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
