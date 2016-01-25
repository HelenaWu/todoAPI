class Api::ListsController < ApiController
  before_action :authenticated?

  def index
    lists = List.all
    render json: lists, each_serializer: ListSerializer
  end

  def create
    user = User.find(params[:user_id])  
    if user == current_user  
      list = user.lists.create(list_params)
      if list.persisted?
        render json: list
      else
        render json: {errors: list.errors.full_messages}, status: :unprocessible_entity
      end
    else
      render json: {errors: "Can't modify other users lists"}, status: :unprocessible_entity
    end
  end

  def update
    begin
      list = find_list
      if list.update(list_params)
        render json: list
      else
        render json: {errors: list.errors.full_messages}, status: :unprocessible_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: {errors: "list not found"}, status: :not_found          
    end    
  end

  def destroy
    begin
      list = find_list     
      list.destroy
      render json: {}, status: :no_content

    rescue ActiveRecord::RecordNotFound
      render json: {errors: "list not found"}, status: :not_found
    end
  end
  private
  def list_params
    params.require(:list).permit(:subject)
  end

  def find_list
    user = User.find(params[:user_id])  
    if user == current_user 
      user.lists.find(params[:id]) 
    else
      raise ActiveRecord::RecordNotFound
    end
  end
end
