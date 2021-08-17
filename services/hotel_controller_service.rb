class HotelControllerService
  def initialize(power_consumption_service:, motion_sensor_service:)
    @power_consumption_service = power_consumption_service
    @motion_sensor_service = motion_sensor_service
  end

  def movement(floor_identifier:, sub_corridor_identifier:)
    @motion_sensor_service.movement_in_sub_corridor(floor_identifier: floor_identifier, sub_corridor_identifier: sub_corridor_identifier)
    @power_consumption_service.switch_on_light(floor_identifier: floor_identifier, sub_corridor_identifier: sub_corridor_identifier)

    extra_powered_required = [0, @power_consumption_service.current_power_per_floor[floor_identifier] - @power_consumption_service.maximum_power_per_floor].max

    sub_corridors_with_no_motion = @motion_sensor_service.sub_corridor_with_no_motion(floor_identifier: floor_identifier)
    extra_powered_required = consume_extra_power(floor_identifier: floor_identifier, sub_corridors: sub_corridors_with_no_motion, extra_power: extra_powered_required, action: :off)

    sub_corridors_with_motion = @motion_sensor_service.sub_corridor_with_motion(floor_identifier: floor_identifier)
    extra_powered_required = consume_extra_power(floor_identifier: floor_identifier, sub_corridors: sub_corridors_with_motion, extra_power: extra_powered_required, action: :off)
  end

  def no_movement(floor_identifier:, sub_corridor_identifier:)
    @motion_sensor_service.no_movement_in_sub_corridor(floor_identifier: floor_identifier, sub_corridor_identifier: sub_corridor_identifier)
    @power_consumption_service.switch_off_light(floor_identifier: floor_identifier, sub_corridor_identifier: sub_corridor_identifier)

    extra_powered_added = [0, @power_consumption_service.maximum_power_per_floor - @power_consumption_service.current_power_per_floor[floor_identifier]].max

    sub_corridors_with_motion = @motion_sensor_service.sub_corridor_with_motion(floor_identifier: floor_identifier)
    extra_powered_added = consume_extra_power(floor_identifier: floor_identifier, sub_corridors: sub_corridors_with_motion, extra_power: extra_powered_added, action: :on)

    sub_corridors_with_no_motion = @motion_sensor_service.sub_corridor_with_no_motion(floor_identifier: floor_identifier)
    extra_powered_added = consume_extra_power(floor_identifier: floor_identifier, sub_corridors: sub_corridors_with_no_motion, extra_power: extra_powered_added, action: :on)
  end

  private
  def consume_extra_power(floor_identifier:, sub_corridors:, extra_power:, action:)
    i = 0
    while i < sub_corridors.length && extra_power > 0
      extra_power -= @power_consumption_service.send("switch_#{action}_air_conditioner",
        floor_identifier: floor_identifier,
        sub_corridor_identifier: sub_corridors[i].identifier
      )
      i += 1
    end

    extra_power
  end

end