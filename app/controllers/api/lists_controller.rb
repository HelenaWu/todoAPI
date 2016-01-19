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

  private
  def list_params
    params.require(:list).permit(:subject)
  end
end
