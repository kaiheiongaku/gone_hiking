class ParksFacade
  class << self
    def pull_parks_info(state = nil, result_limit = 50)
      endpoint = '/api/v1/parks'
      params = {
        stateCode: state,
        limit: result_limit
       }
      parks_info = ParksService.call_parks_db(endpoint, params)[:data]
      parks_info.map do |park_info|
        Park.new(park_info)
      end
    end
  end
end
