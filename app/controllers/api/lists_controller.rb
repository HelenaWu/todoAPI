class Api::ListsController < ApiController
  before_action :authenticated?

  def create
    user = User.find(params[:user_id])    
    list = user.lists.create(list_params)
    if list.persisted?
      render json: list
    else
      render json: {errors: list.errors.full_messages}, status: :unprocessible_entity
    end
  end

  def destroy
    begin
      user = User.find(params[:user_id])
      list = user.lists.find(params[:id])
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
end
