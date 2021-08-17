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

power_consumption_service = PowerConsumptionService.new(hotel: hotel)
motion_sensor_service = MotionSensorService.new(hotel: hotel)

hotel_controller_service = HotelControllerService.new(
  power_consumption_service: power_consumption_service,
  motion_sensor_service: motion_sensor_service
)
OutputPrinterService.print_status(hotel: hotel)

reader.commands.each do |command|
  if command.movement?
    hotel_controller_service.movement(
      floor_identifier: command.floor,
      sub_corridor_identifier: command.sub_corridor
    )
  else
    hotel_controller_service.no_movement(
      floor_identifier: command.floor,
      sub_corridor_identifier: command.sub_corridor
    )
  end
  OutputPrinterService.print_status(hotel: hotel)
end
