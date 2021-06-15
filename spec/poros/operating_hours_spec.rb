require 'rails_helper'

describe OperatingHours do
  it 'exists and has attributes' do
    hours_info = File.read('spec/fixtures/poros/hours_spec.json')
    hours_data = JSON.parse(hours_info, symbolize_names: true)
    hours = OperatingHours.new(hours_data)

    expect(hours).to be_an(OperatingHours)
    expect(hours.description).to eq(
      "In general, the Appalachian Trail is open year-round. The northern terminus at Mount Katahdin in Maine is within Baxter State Park, which may be closed in winter months, depending on weather conditions. \nParticular sections of the Trail, and less-developed roads accessing the Trail, may be closed temporarily for a number of reasons, but otherwise the trail is open."
    )
    expect(hours.exceptions).to eq([])
    expect(hours.monday).to eq("All Day")
    expect(hours.tuesday).to eq("All Day")
    expect(hours.wednesday).to eq("All Day")
    expect(hours.thursday).to eq("All Day")
    expect(hours.friday).to eq("All Day")
    expect(hours.saturday).to eq("All Day")
    expect(hours.sunday).to eq("All Day")
  end
end
