class Api::V1::ParksController < ApplicationController
  def index
  render json: ParksSerializer.new(
      ParksFacade.pull_parks_info(params[:state])
    )
  end
end
