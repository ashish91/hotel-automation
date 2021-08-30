#!/usr/bin/ruby
require 'pry'

require File.join(Dir.pwd, 'require_tree')

FILENAME = ARGV[0]

reader = InputReaderService.new
reader.read_file(file: FILENAME)
hotel = Hotel::Building.new(
  no_of_floors: reader.floors,
  main_corridors_per_floor: reader.main_corridors,
  sub_corridors_per_floor: reader.sub_corridors
)

OutputPrinterService.print_status(hotel: hotel)

reader.commands.each do |command|
  if command.movement?
    hotel.movement!(
      floor_identifier: command.floor,
      sub_corridor_identifier: command.sub_corridor
    )
  else
    hotel.no_movement!(
      floor_identifier: command.floor,
      sub_corridor_identifier: command.sub_corridor
    )
  end
  OutputPrinterService.print_status(hotel: hotel)
end
