require_relative 'main_corridor'
require_relative 'sub_corridor'
require_relative '../../concerns/hashify'

class Hotel::Floor
  include Hashify
  attr_reader :main_corridors, :sub_corridors, :main_corridors_map, :sub_corridors_map, :identifier

  def initialize(main_corridors:, sub_corridors:, identifier:)
    @main_corridors = main_corridors.times.map.with_index { |f, i| Hotel::MainCorridor.new(identifier: i+1) }
    @sub_corridors = sub_corridors.times.map.with_index { |f, i| Hotel::SubCorridor.new(identifier: i+1) }

    @main_corridors_map = build_map(@main_corridors)
    @sub_corridors_map = build_map(@sub_corridors)

    @identifier = identifier
  end
end