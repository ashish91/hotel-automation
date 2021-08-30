require_relative 'floor'
require_relative '../../concerns/hashify'

module Hotel
  class Building
    include Hashify
    attr_reader :floors

    def initialize(no_of_floors:, main_corridors_per_floor:, sub_corridors_per_floor:)
      @floors = no_of_floors.times.map.with_index do |f, i|
          Hotel::Floor.new(
            identifier: i+1,
            main_corridors: main_corridors_per_floor,
            sub_corridors: sub_corridors_per_floor
          )
      end

      @floors_map = build_map(@floors)
    end

    def movement!(floor_identifier:, sub_corridor_identifier:)
      floor = get_floor(floor_identifier: floor_identifier)
      floor.movement_in_sub_corridor!(sub_corridor_identifier: sub_corridor_identifier)
    end

    def no_movement!(floor_identifier:, sub_corridor_identifier:)
      floor = get_floor(floor_identifier: floor_identifier)
      floor.no_movement_in_sub_corridor!(sub_corridor_identifier: sub_corridor_identifier)
    end

    def get_floor(floor_identifier:)
      @floors_map[floor_identifier]
    end
  end
end