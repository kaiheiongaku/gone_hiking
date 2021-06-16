require 'rails_helper'

describe Image do
  it 'exists and has attributes' do
    image_info = File.read('spec/fixtures/poros/image_spec.rb')
    image_data = JSON.parse(image_info, symbolize_names: true)
    image = Image.new(image_data)

    expect(image).to be_an(Image)
    expect(image.credit).to eq('Photo Credit: ATC/Benjamin Hays')
    expect(image.title).to eq('McAfee Knob')
    expect(image.description).to eq('Silhouette of a man with backpack standing on McAfee Knob at sunset with mountains in the distance.')
    expect(image.caption).to eq('McAfee Knob is one of the most popular locations along the A.T. to take photographs.')
    expect(image.url).to eq('https://www.nps.gov/common/uploads/structured_data/3C8397D6-1DD8-B71B-0BEF4C54462A1EB3.jpg')
  end
end
