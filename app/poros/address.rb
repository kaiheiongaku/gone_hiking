class Address
  attr_reader :zip_code, :state, :city, :street

  def initialize(address_info)
    @zip_code = address_info[:postalCode]
    @state    = address_info[:stateCode]
    @city     = address_info[:city]
    @street   = address_info[:line1]
  end
end
