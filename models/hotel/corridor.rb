require_relative '../electrical_unit/light'
require_relative '../electrical_unit/air_conditioner'
require 'forwardable'

module Hotel
  class Hotel::Corridor
    extend Forwardable
    attr_reader :light, :air_conditioner, :identifier

    def_delegators :@motion, :movement?

    def initialize(identifier:, light_state:, air_conditioner_state:)
      @light = ElectricalUnit::Light.new(power_consumption: 5, power_state: light_state)
      @air_conditioner = ElectricalUnit::AirConditioner.new(power_consumption: 10, power_state: air_conditioner_state)
      @motion = Motion.new

      @identifier = identifier
    end

    def movement!
      @motion.movement!
      light.switch_on!
    end

    def no_movement!
      @motion.no_movement!
      light.switch_off!
    end

    def total_power
      power = 0
      power += @air_conditioner.power_consumption if @air_conditioner.switched_on?
      power += @light.power_consumption if @light.switched_on?
      power
    end

    private
    attr_reader :motion
  end
end