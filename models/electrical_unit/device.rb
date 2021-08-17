module ElectricalUnit
  class Device
    POWER_STATE = { off: 0, on: 1}.freeze
    attr_reader :power_consumption

    def initialize(power_consumption:, power_state:)
      @power_consumption = power_consumption
      @power_state = power_state
    end

    def switched_on?
      @power_state == POWER_STATE[:on]
    end

    def switch_on!
      @power_state = POWER_STATE[:on]
    end

    def switch_off!
      @power_state = POWER_STATE[:off]
    end
  end
end