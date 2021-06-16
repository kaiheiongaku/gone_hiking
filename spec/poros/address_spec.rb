require 'rails_helper'

describe Address do
  it 'exists and has attributes' do
    address_info = File.read('spec/fixtures/poros/address_spec.json')
    address_data = JSON.parse(address_info, symbolize_names: true)
    address = Address.new(address_data)

    expect(address).to be_an(Address)
    expect(address.zip_code).to eq('25979')
    expect(address.city).to eq('Pipestem')
    expect(address.state).to eq('WV')
    expect(address.street).to eq('3405 Pipestem Drive')
  end
end
