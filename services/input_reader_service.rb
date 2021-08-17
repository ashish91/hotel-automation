class InputReaderService
  attr_reader :floors, :main_corridors, :sub_corridors, :commands

  def initialize
    @commands = []
    @floors = 0
    @main_corridors = 0
    @sub_corridors = 0
  end

  def read_file(file:)
    File.open(file, "r") do |f|
      f.each_line.with_index do |line, i|
        if i == 0
          commands = line.split(',').map(&:strip)
          commands.each do |v|
            attribute, val = v.split(':').map(&:strip)
            case attribute
            when "Floors"
              @floors = val.to_i
            when "Main Corridors"
              @main_corridors = val.to_i
            when "Sub Corridors"
              @sub_corridors = val.to_i
            end
          end
        else
          commands = line.split(',').map(&:strip)
          movement, floor, sub_corridor = nil, nil, nil
          commands.each do |v|
            attribute, val = v.split(':').map(&:strip)
            case attribute
            when "Movement"
              movement = val.to_i
            when "Floor"
              floor = val.to_i
            when "Sub Corridor"
              sub_corridor = val.to_i
            end
          end
          @commands.push(
            MovementCommand.new(
              movement: movement,
              floor: floor,
              sub_corridor: sub_corridor
            )
          )
        end
      end
    end
  end

  class MovementCommand
    attr_accessor :movement, :floor, :sub_corridor

    def initialize(movement:, floor:, sub_corridor:)
      @movement = movement
      @floor = floor
      @sub_corridor = sub_corridor
    end

    def movement?
      @movement == 1
    end
  end
end