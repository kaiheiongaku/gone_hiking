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

    it 'can pull different numbers of parks without state',:vcr do
      get '/api/v1/parks?limit=200'

      expect(response).to be_successful

      parks = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(parks.size).to eq(200)
    end

    it 'can pull different number of parks with state' do
      get '/api/v1/parks?state=wv&limit=2'

      expect(response).to be_successful

      parks = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(parks.size).to eq(2)
      expect(parks.first.address.state).to eq('WV')
    end

    it 'can sort parks by name alphabetically' do

    end

    it 'can filter parks with free entrance fees' do

    end
  end

  describe 'sad path' do
    it 'handles different capitalization of state codes', :vcr do
      get '/api/v1/parks?state=wV'

      expect(response).to be_successful

      wV_json = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(wV_json).to be_an(Array)
      expect(wV_json.count).to eq(9)
    end

    it 'returns an error if non-state code is provided', :vcr do
      get '/api/v1/parks?state=notAstate'

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error = JSON.parse(response.body, symbolize_names: true)[:error]
      expect(error).to eq('Cannot read state format.  Please use postal state abbreviations.')
    end

    it 'returns an error if state does not exist', :vcr do
      get '/api/v1/parks?state=pl'

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error = JSON.parse(response.body, symbolize_names: true)[:error]
      expect(error).to eq('Not a state.  Please choose one of the 50 states.')
    end

    it 'returns an error if user does not include parks url', :vcr do
      get '/api/v1/notParks'

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error = JSON.parse(response.body, symbolize_names: true)[:error]
      expect(error).to eq('No route matches api/v1/notParks. Though you may insist, this route does not exist.')
    end

    it 'can remove periods from state abbreviations', :vcr do
      get '/api/v1/parks?state=w.v.'

      expect(response).to be_successful

      period_json = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(period_json).to be_an(Array)
      expect(period_json.count).to eq(9)
    end
  end
end
