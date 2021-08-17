require_relative 'floor'
require_relative '../../concerns/hashify'

module Hotel
  class Building
    include Hashify
    attr_reader :floors, :floors_map, :no_of_floors, :main_corridors_per_floor, :sub_corridors_per_floor

    def initialize(no_of_floors:, main_corridors_per_floor:, sub_corridors_per_floor:)
      @no_of_floors = no_of_floors
      @main_corridors_per_floor = main_corridors_per_floor
      @sub_corridors_per_floor = sub_corridors_per_floor

      @floors = no_of_floors.times.map.with_index do |f, i|
          Hotel::Floor.new(
            identifier: i+1,
            main_corridors: main_corridors_per_floor,
            sub_corridors: sub_corridors_per_floor
          )
      end

      @floors_map = build_map(@floors)
    end
  end
end