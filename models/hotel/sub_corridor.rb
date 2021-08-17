require_relative 'corridor'

class Hotel::SubCorridor < Hotel::Corridor
  def initialize(identifier:)
    super(
      identifier: identifier,
      light_state: ElectricalUnit::Device::POWER_STATE[:off],
      air_conditioner_state: ElectricalUnit::Device::POWER_STATE[:on]
    )
  end
end