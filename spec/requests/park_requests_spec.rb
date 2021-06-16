require 'rails_helper'

describe 'park information requests' do
  describe 'happy path' do
    it 'can pull all parks for a state', :vcr do
      get '/api/v1/parks?state=wv'

      expect(response).to be_successful

      parks_in_wv_json = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(parks_in_wv_json).to be_a(Array)
      expect(parks_in_wv_json.count).to eq(9)

      expect(parks_in_wv_json.first).to have_key(:id)
      expect(parks_in_wv_json.first[:id]).to eq('null')

      expect(parks_in_wv_json.first).to have_key(:type)
      expect(parks_in_wv_json.first[:type]).to eq('parks')

      expect(parks_in_wv_json.first).to have_key(:attributes)
      expect(parks_in_wv_json.first[:attributes]).to be_a(Hash)
      expect(parks_in_wv_json.first[:attributes].keys.count).to eq(9)
    end

    it 'can pull all parks', :vcr do
      get '/api/v1/parks'

      expect(response).to be_successful

      all_parks = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(all_parks).to be_a(Array)
      expect(all_parks.count).to eq(50)

      expect(all_parks.first).to have_key(:id)
      expect(all_parks.first[:id]).to eq('null')

      expect(all_parks.first).to have_key(:type)
      expect(all_parks.first[:type]).to eq('parks')

      expect(all_parks.first).to have_key(:attributes)
      expect(all_parks.first[:attributes]).to be_a(Hash)
      expect(all_parks.first[:attributes].keys.count).to eq(9)
    end
  end
end
