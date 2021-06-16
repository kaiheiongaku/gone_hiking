class Api::V1::ParksController < ApplicationController
  before_action :validate_state_code, if: :state_code_present?

  def index
      render json: ParksSerializer.new(@parks)
  end

  def state_code_present?
    if params[:state]
      params[:state].delete!('.') if params[:state].include?('.')
      @parks = ParksFacade.pull_parks_info(params[:state])
      true
    else
      @parks = ParksFacade.pull_parks_info
      false
    end
  end
end
