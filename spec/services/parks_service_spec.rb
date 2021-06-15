require 'rails_helper'

describe ParksService do
  describe 'returns park information' do
    it 'can return all parks with their information' do
      endpoint = '/api/v1/parks'

      parks = ParksService.call_parks_db(endpoint)

      expect(parks).to be_a(Hash)
      expect(parks[:data].keys.count).to eq(872)

      park = parks[:data].first
      expect(park).to be_a(Hash)
      expect(park.keys).to eq(10)
      expect(park).to have_keys(:nps_id, :full_name, :description, :phone_number, :entrance_fee, :hours, :address, :image, :weather_info)

      expect(park[:hours]).to have_keys(:description, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday)

      expect(park[:address]).to have_keys(:postal_code, :city, :state, :street)

      expect(park[:image]).to have_keys(:credit, :title, :description, :caption, :url)
    end

    it 'can return all parks within a state' do

    end
  end
end
