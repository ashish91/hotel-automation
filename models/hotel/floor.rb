require_relative 'main_corridor'
require_relative 'sub_corridor'
require_relative '../../concerns/hashify'

class Hotel::Floor
  include Hashify
  attr_reader :main_corridors, :sub_corridors, :identifier

  def initialize(main_corridors:, sub_corridors:, identifier:)
    @main_corridors = main_corridors.times.map.with_index { |f, i| Hotel::MainCorridor.new(identifier: i+1) }
    @sub_corridors = sub_corridors.times.map.with_index { |f, i| Hotel::SubCorridor.new(identifier: i+1) }

    @main_corridors_map = build_map(@main_corridors)
    @sub_corridors_map = build_map(@sub_corridors)

    @identifier = identifier
  end

  def get_sub_corridor(sub_corridor_identifier:)
    @sub_corridors_map[sub_corridor_identifier]
  end

  def get_sub_corridors_with_no_motion
    @sub_corridors.filter { |sub_corridor| !sub_corridor.movement? }
  end

  def get_sub_corridors_with_motion
    @sub_corridors.filter { |sub_corridor| sub_corridor.movement? }
  end

  def movement_in_sub_corridor!(sub_corridor_identifier:)
    sub_corridor = get_sub_corridor(sub_corridor_identifier: sub_corridor_identifier)
    sub_corridor.movement!

    current = total_power
    maximum = max_power
    sub_corridors = @sub_corridors.filter { |sc| sc.air_conditioner.switched_on? }

    while current > maximum
      curr_sc = sub_corridors.pop
      break if curr_sc.nil?
      curr_sc.air_conditioner.switch_off!
      current -= curr_sc.air_conditioner.power_consumption
    end
  end

  def no_movement_in_sub_corridor!(sub_corridor_identifier:)
    sub_corridor = get_sub_corridor(sub_corridor_identifier: sub_corridor_identifier)
    sub_corridor.no_movement!

    current = total_power
    maximum = max_power
    sub_corridors = @sub_corridors.filter { |sc| !sc.air_conditioner.switched_on? }

    while current < maximum && sub_corridors.length > 0
      curr_sc = sub_corridors.pop
      if curr_sc.nil? || curr_sc.air_conditioner.power_consumption + current > maximum
        break
      end
      curr_sc.air_conditioner.switch_on!
      current += curr_sc.air_conditioner.power_consumption
    end
  end

  def total_power
    (@main_corridors + @sub_corridors).sum { |corridor| corridor.total_power }
  end

  def max_power
    ((@main_corridors.length * 15) + (@sub_corridors.length * 10))
  end
end