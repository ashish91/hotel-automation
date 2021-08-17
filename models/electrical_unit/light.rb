require_relative 'device'

class ElectricalUnit::Light < ElectricalUnit::Device
  def initialize(power_consumption:, power_state:)
    super(power_consumption: power_consumption, power_state: power_state)
  end
end