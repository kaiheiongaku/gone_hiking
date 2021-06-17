class Api::V1::SearchesController <  ApplicationController

  def create
    user = User.find_by(params[:user])
    @search = Search.new(user: user, text: search_params[:text])
    if @search.save
      render json: SearchesSerializer.new(@search), status: 201
    else
      search_errors
    end
  end

  private
  def search_params
    params.require(:search).permit(:text)
  end
end
