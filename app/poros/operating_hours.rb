class OperatingHours
  attr_reader :description, :exceptions, :monday, :tuesday, :wednesday,
              :thursday,    :friday,     :sunday, :saturday

  def initialize(hours_data)
    @description = hours_data[:description]
    @exceptions  = hours_data[:exceptions]
    @monday      = hours_data[:standardHours][:monday]
    @tuesday     = hours_data[:standardHours][:tuesday]
    @wednesday   = hours_data[:standardHours][:wednesday]
    @thursday    = hours_data[:standardHours][:thursday]
    @friday      = hours_data[:standardHours][:friday]
    @saturday    = hours_data[:standardHours][:saturday]
    @sunday      = hours_data[:standardHours][:sunday]
  end
end
