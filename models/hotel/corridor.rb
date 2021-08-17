require_relative '../electrical_unit/light'
require_relative '../electrical_unit/air_conditioner'

module Hotel
  class Hotel::Corridor
    attr_reader :light, :air_conditioner, :identifier

    def initialize(identifier:, light_state:, air_conditioner_state:)
      @light = ElectricalUnit::Light.new(power_consumption: 5, power_state: light_state)
      @air_conditioner = ElectricalUnit::AirConditioner.new(power_consumption: 10, power_state: air_conditioner_state)

      @identifier = identifier
    end
  end
end