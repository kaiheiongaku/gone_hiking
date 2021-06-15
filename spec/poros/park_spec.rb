require 'rails_helper'

describe Park do
  describe 'park creation' do
    it 'is a park object with attributes' do
      park_file = File.read('spec/fixtures/poros/park_spec.json')

      park_data = JSON.parse(background_file, symbolize_names: true)

      park = Park.new(park_data)

      expect(park).to be_a(Park)

      expect(park.nps_id).to eq()
      expect(park.full_name)
      expect(park.description).to eq()
      expect(park.phone_number).to eq()
      expect(park.entrance_fee).to eq()

      expect(park.hours).to be_a(Hash)
      expect(park.hours).to have_keys(:description, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday)
      #hours object?
      expect(park.address).to be_a(Hash)
      expect(park.address).to have_keys(:postal_code, :city, :state, :street)
      #object?
      expect(park.image).to be_a(Hash)
      expect(park.image).to have_keys(:credit, :title, :description, :caption, :url)

      #object?
      expect(park.weather_info).to eq()


      # :nps_id,
      # :full_name, :description, :phone_number, :entrance_fee, :hours, :address, :image, :weather_info)

      # expect(park[:hours]).to have_keys(:description, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday)

      # expect(park[:address]).to have_keys(:postal_code, :city, :state, :street)
      #
      # expect(park[:image]).to have_keys(:credit, :title, :description, :caption, :url)

    end
  end
end
