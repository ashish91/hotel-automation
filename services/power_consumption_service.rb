class PowerConsumptionService
  attr_reader :current_power_per_floor, :maximum_power_per_floor

  def initialize(hotel:)
    @hotel = hotel
    @current_power_per_floor = compute_power_per_floor
    @maximum_power_per_floor = compute_max_power_per_floor
  end

  def switch_on_light(floor_identifier:, sub_corridor_identifier:)
    light = @hotel.floors_map[floor_identifier].sub_corridors_map[sub_corridor_identifier].light
    light.switch_on!

    @current_power_per_floor[floor_identifier] += light.power_consumption
  end

  def switch_off_light(floor_identifier:, sub_corridor_identifier:)
    light = @hotel.floors_map[floor_identifier].sub_corridors_map[sub_corridor_identifier].light
    light.switch_off!

    @current_power_per_floor[floor_identifier] -= light.power_consumption
  end

  def switch_on_air_conditioner(floor_identifier:, sub_corridor_identifier:)
    air_conditioner = @hotel.floors_map[floor_identifier].sub_corridors_map[sub_corridor_identifier].air_conditioner
    return 0 if air_conditioner.switched_on?

    air_conditioner.switch_on!

    @current_power_per_floor[floor_identifier] += air_conditioner.power_consumption
    air_conditioner.power_consumption
  end

  def switch_off_air_conditioner(floor_identifier:, sub_corridor_identifier:)
    air_conditioner = @hotel.floors_map[floor_identifier].sub_corridors_map[sub_corridor_identifier].air_conditioner
    return 0 unless air_conditioner.switched_on?

    air_conditioner.switch_off!

    @current_power_per_floor[floor_identifier] -= air_conditioner.power_consumption
    air_conditioner.power_consumption
  end

  private
  def compute_power_per_floor
    power_per_floor = {}

    @hotel.floors.each do |floor|
      power_per_floor[floor.identifier] = 0
      (floor.main_corridors + floor.sub_corridors).each do |corridor|
        [:air_conditioner, :light].each do |device|
          if corridor.send(device).switched_on?
            power_per_floor[floor.identifier] += corridor.send(device).power_consumption
          end
        end
      end
    end

    power_per_floor
  end

  def compute_max_power_per_floor
    (@hotel.main_corridors_per_floor * 15) + (@hotel.sub_corridors_per_floor * 10)
  end
end