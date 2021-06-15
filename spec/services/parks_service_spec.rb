require 'rails_helper'

describe ParksService do
  describe 'returns park information' do
    it 'can return all parks with their information', :vcr do
      endpoint = '/api/v1/parks'

      parks = ParksService.call_parks_db(endpoint)

      expect(parks).to be_a(Hash)
      expect(parks[:data].count).to eq(50)

      park = parks[:data].first
      expect(park).to be_a(Hash)
      expect(park.keys.count).to eq(23)
      expect(park).to have_key(:id)
    end

    it 'can return all parks within a state', :vcr do
      endpoint = '/api/v1/parks'
      params = { stateCode: 'wv' }

      parks = ParksService.call_parks_db(endpoint, params)

      expect(parks).to be_a(Hash)
      expect(parks[:data].count).to eq(9)
    end
  end
end
