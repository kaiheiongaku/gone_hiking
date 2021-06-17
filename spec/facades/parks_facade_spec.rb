require 'rails_helper'

describe ParksFacade do
  describe 'parks' do
    it 'returns park objects without parameters', :vcr do
      parks = ParksFacade.pull_parks_info

      expect(parks).to be_an(Array)
      expect(parks.first).to be_a(Park)
    end

    it 'returns park objects with state parameters', :vcr do
      parks = ParksFacade.pull_parks_info('wv')

      expect(parks).to be_an(Array)
      expect(parks.first).to be_a(Park)
    end

    it 'can return park objects with limit parameters', :vcr do
      parks = ParksFacade.pull_parks_info(nil, 5)

      expect(parks).to be_an(Array)
      expect(parks.first).to be_a(Park)
      expect(parks.size).to eq(5)
    end
  end
end
