require 'rails_helper'

describe Park do
  describe 'park creation' do
    it 'is a park object with attributes' do
      park_file = File.read('spec/fixtures/poros/park_spec.json')
      park_data = JSON.parse(park_file, symbolize_names: true)
      park = Park.new(park_data)

      expect(park).to be_a(Park)

      expect(park.nps_id).to eq('FAEF5684-83A4-4CF2-A701-60CF8D4014BD')
      expect(park.full_name).to eq('Appalachian National Scenic Trail')
      expect(park.description).to eq(
        "The Appalachian Trail is a 2,180+ mile long public footpath that traverses the scenic, wooded, pastoral, wild, and culturally resonant lands of the Appalachian Mountains. Conceived in 1921, built by private citizens, and completed in 1937, today the trail is managed by the National Park Service, US Forest Service, Appalachian Trail Conservancy, numerous state agencies and thousands of volunteers."
      )
      expect(park.phone_number).to eq('3045356278')
      expect(park.entrance_fee).to eq('0.00')
      expect(park.weather_info).to eq(
        "It is your responsibility to be prepared for all weather conditions, including extreme and unexpected weather changes year-round. As the trail runs from Georgia to Maine there will be different weather conditions depending on your location. For weather along specific sections of the trail and at specific shelters, please refer to: http://www.atweather.org/"
      )

      expect(park.hours).to be_an(OperatingHours)
      expect(park.office_address).to be_an(Address)
      expect(park.image).to be_an(Image)
    end

    it 'can create a park with many attributes blank' do
      odd_park_file = File.read('spec/fixtures/poros/odd_park_spec.json')
      odd_park_data = JSON.parse(odd_park_file, symbolize_names: true)
      odd_park = Park.new(odd_park_data)

      expect(odd_park).to be_a(Park)
      expect(odd_park.weather_info).to eq('')
      expect(odd_park.image).to eq(nil)
      expect(odd_park.office_address).to eq(nil)
      expect(odd_park.hours).to eq(nil)
    end
  end
end
