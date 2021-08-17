require_relative 'corridor'

class Hotel::MainCorridor < Hotel::Corridor
  def initialize(identifier:)
    super(
      identifier: identifier,
      light_state: ElectricalUnit::Device::POWER_STATE[:on],
      air_conditioner_state: ElectricalUnit::Device::POWER_STATE[:on]
    )
  end
end