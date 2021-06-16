class ParksService
  class << self
    def call_parks_db(endpoint, params = {})
      response = connection.get(endpoint) do |request|
        request.params = params
        request.headers['X-API-KEY'] = ENV['PARKS_API_KEY']
      end
      JSON.parse(response.body, symbolize_names: true)
    end

    private
    def connection
      Faraday.new('https://developer.nps.gov')
    end
  end
end
