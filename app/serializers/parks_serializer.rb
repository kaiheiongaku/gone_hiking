class ParksSerializer
  include FastJsonapi::ObjectSerializer
  attributes :nps_id, :full_name, :description, :phone_number, :entrance_fee, :hours, :office_address, :image, :weather_info
  set_id { 'null' }
end
