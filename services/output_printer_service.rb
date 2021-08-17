class OutputPrinterService
  class << self

    def print_status(hotel:)
      puts '-' * 100
      hotel.floors.each do |floor|
        puts "Floor #{floor.identifier}"
        puts
        floor.main_corridors.each do |main_corridor|
          puts "Main Corridor #{main_corridor.identifier} Light #{main_corridor.identifier}: #{main_corridor.light.switched_on? ? 'ON' : 'OFF'} AC: #{main_corridor.air_conditioner.switched_on? ? 'ON' : 'OFF'}"
        end
        puts
        floor.sub_corridors.each do |sub_corridor|
          puts "Sub Corridor #{sub_corridor.identifier} Light #{sub_corridor.identifier}: #{sub_corridor.light.switched_on? ? 'ON' : 'OFF'} AC: #{sub_corridor.air_conditioner.switched_on? ? 'ON' : 'OFF'}"
        end
        puts
      end
      puts '-' * 100
      puts
    end
  end
end