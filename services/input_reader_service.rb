require 'forwardable'
require_relative 'commands/default_state_command'
require_relative 'commands/movement_command'

class InputReaderService
  extend Forwardable

  attr_reader :commands
  def_delegators :@default_state, :floors, :main_corridors, :sub_corridors

  def initialize
    @commands = []
    @default_state = DefaultStateCommand.new
  end

  def read_file(file:)
    File.open(file, "r") do |f|
      @default_state.parse_line(f.readline)
      f.each_line do |line|
        movement_command = MovementCommand.new
        movement_command.parse_line(line)
        @commands.push(movement_command)
      end
    end
  end
end