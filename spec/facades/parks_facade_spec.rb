require 'rails_helper'

describe ParksFacade do
  describe 'parks' do
    it 'returns park objects without parameters' do
      parks = ParksFacade.pull_parks_info

      expect(parks).to be_an(Array)
      expect(parks.first).to be_a(Park)
    end

    it 'returns park objects with state parameters' do
      parks = ParksFacade.pull_parks_info('wv')

      expect(parks).to be_an(Array)
      expect(parks.first).to be_a(Park)
    end
  end
end



expect(park).to have_keys(:nps_id, :full_name, :description, :phone_number, :entrance_fee, :hours, :address, :image, :weather_info)

expect(park[:hours]).to have_keys(:description, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday)

expect(park[:address]).to have_keys(:postal_code, :city, :state, :street)

expect(park[:image]).to have_keys(:credit, :title, :description, :caption, :url)
