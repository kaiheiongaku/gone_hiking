require 'rails_helper'

describe 'park information requests' do
  describe 'happy path' do
    it 'can pull all parks for a state' do
      visit '/api/v1/parks?state=wv'

      expect(response).to be_successful

      parks_in_wv_json = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(parks_in_wv_json).to be_a(Hash)
      expect(parks_in_wv_json).to have_key(:id)
      expect(parks_in_wv_json[:id]).to eq('null')

      ## test for speific attributes, test for number of parks, and that each park has specific attributes
    end

    # it 'can show information about a particular park' do
    #   visit '/api/v1/parks?state=WV'
    # end
  end
end
