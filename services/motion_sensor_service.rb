class MotionSensorService
  MOTIONS = { no_movement: 0, movement: 1 }.freeze
  attr_reader :motions_state

  def initialize(hotel:)
    @hotel = hotel
    @motions_state = build_default_motions_state(hotel)
  end

  def movement_in_sub_corridor(floor_identifier:, sub_corridor_identifier:)
    floor = @hotel.floors_map[floor_identifier]
    sub_corridor = @hotel.floors_map[floor_identifier].sub_corridors_map[sub_corridor_identifier]
    @motions_state[floor.identifier][:sub_corridors][sub_corridor.identifier] = MOTIONS[:movement]
  end

  def no_movement_in_sub_corridor(floor_identifier:, sub_corridor_identifier:)
    floor = @hotel.floors_map[floor_identifier]
    sub_corridor = @hotel.floors_map[floor_identifier].sub_corridors_map[sub_corridor_identifier]
    @motions_state[floor.identifier][:sub_corridors][sub_corridor.identifier] = MOTIONS[:no_movement]
  end

  def sub_corridor_with_no_motion(floor_identifier:)
    filter_sub_corridor_on_motion(floor_identifier, :no_movement)
  end

  def sub_corridor_with_motion(floor_identifier:)
    filter_sub_corridor_on_motion(floor_identifier, :movement)
  end

  private
  def filter_sub_corridor_on_motion(floor_identifier, action)
    sub_corridors_map = @hotel.floors_map[floor_identifier].sub_corridors_map
    filtered_sub_corridors = []

    @motions_state[floor_identifier][:sub_corridors].each do |sub_corridor_identifier, power_state|
      if power_state == MOTIONS[action]
        filtered_sub_corridors.push(sub_corridors_map[sub_corridor_identifier])
      end
    end

    filtered_sub_corridors
  end

  def build_default_motions_state(hotel)
    default_state = {}
    @hotel.floors.each do |floor|
      default_state[floor.identifier] = { main_corridors: {}, sub_corridors: {} }

      default_state[floor.identifier].keys.each do |corridor_type|
        floor.send(corridor_type).each do |corridor|
          default_state[floor.identifier][corridor_type][corridor.identifier] = MOTIONS[:no_movement]
        end
      end
    end

    default_state
  end

end