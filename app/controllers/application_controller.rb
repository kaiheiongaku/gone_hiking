class ApplicationController < ActionController::API
  def raise_not_found!
    render json: { error: "No route matches #{params[:unmatched_route]}. Though you may insist, this route does not exist." }.to_json,
           status: 404
  end

  def user_errors
    if !params[:user][:password_confirmation]
      render json: { errors: 'Missing password confirmation.'}, status: 400
    else
      render json: { errors: @user.errors.full_messages }, status: 400
    end
  end

  def search_errors
    render json: { errors: @search.errors.full_messages }, status: 400
  end

  def something_went_wrong
    render json: { error: "Something went wrong.  Please try again later."}, status: 404
  end

  def validate_state_code
    if params[:state].size != 2
      render json: { error: "Cannot read state format.  Please use postal state abbreviations."}, status: 404
    elsif @parks == []
      render json: { error: "Not a state.  Please choose one of the 50 states."}, status: 404
    end
  end
end
