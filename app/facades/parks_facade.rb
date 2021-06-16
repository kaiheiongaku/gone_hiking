class ParksFacade
  class << self
    def pull_parks_info(state = nil)
      endpoint = '/api/v1/parks'
      params = { stateCode: state }
      parks_info = ParksService.call_parks_db(endpoint, params)[:data]
      parks_info.map do |park_info|
        Park.new(park_info)
      end
    end
  end
end
