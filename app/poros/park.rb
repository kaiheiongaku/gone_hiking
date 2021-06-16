class Park
  attr_reader :nps_id, :full_name, :description,  :phone_number, :entrance_fee,
              :hours,  :image,     :weather_info, :office_address
  def initialize(park_data)
    @nps_id          = park_data[:id]
    @full_name       = park_data[:fullName]
    @description     = park_data[:description]
    @phone_number    = park_data[:contacts][:phoneNumbers].first[:phoneNumber] unless park_data[:contacts][:phoneNumbers] == []
    @entrance_fee    = park_data[:entranceFees].first[:cost] unless park_data[:entranceFees].first == nil
    @hours           = OperatingHours.new(park_data[:operatingHours].first) unless park_data[:operatingHours].first == nil
    @office_address  = Address.new(park_data[:addresses].first) unless park_data[:addresses].first == nil
    @image           = Image.new( park_data[:images].first) unless park_data[:images].first == nil
    @weather_info    = park_data[:weatherInfo]
  end
end
