# Sample input
# Floors MainCorridors Corridors
# 2 1 2
# Movement/No movement Floor Sub corridor
# Movement - 1
# No movement - 0
# 1 1 2
# 0 1 2
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
        #TODO Add input checks
        if i == 0
          @floors, @main_corridors, @sub_corridors = line.split(' ').map(&:to_i)
        else
          @movement, @floor, @sub_corridor = line.split(' ').map(&:to_i)
          @commands.push(
            MovementCommand.new(
              movement: @movement,
              floor: @floor,
              sub_corridor: @sub_corridor
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