class Api::V1::ParksController < ApplicationController
  before_action :validate_state_code, if: :state_code_present?

  def index
    @parks.sort_by {|park| park.full_name } if params[:alphasort]
    render json: ParksSerializer.new(@parks)
  end

  def state_code_present?
    if params[:state]
      params[:state].delete!('.') if params[:state].include?('.')
      @parks = ParksFacade.pull_parks_info(params[:state], params[:limit])
      true
    else
      @parks = ParksFacade.pull_parks_info(nil, params[:limit])
      false
    end
  end
end
