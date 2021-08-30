require File.join(Dir.pwd, 'specs/spec_helper')

describe "Hotel::Building" do
  let (:hotel) {
    Hotel::Building.new(
      no_of_floors: 2,
      main_corridors_per_floor: 1,
      sub_corridors_per_floor: 2
    )
  }

  it "turns on all AC's by default" do
    hotel.floors.each do |floor|
      [:main_corridors, :sub_corridors].each do |corridor_type|
        floor.send(corridor_type).each do |corridor|
          expect(corridor.air_conditioner.switched_on?).to be_truthy
        end
      end
    end
  end

  it "turns on lights for main corridors by default" do
    hotel.floors.each do |floor|
      floor.main_corridors.each do |corridor|
        expect(corridor.light.switched_on?).to be_truthy
      end

      floor.sub_corridors.each do |corridor|
        expect(corridor.light.switched_on?).to be_falsey
      end
    end
  end

  it "turns on light for sub corridor on movement" do
    hotel.movement!(
      floor_identifier: 1,
      sub_corridor_identifier: 2
    )

    floor = hotel.get_floor(floor_identifier: 1)
    sub_corridor = floor.get_sub_corridor(sub_corridor_identifier: 2)
    expect(sub_corridor.light.switched_on?).to be_truthy
    expect(sub_corridor.air_conditioner.switched_on?).to be_falsey
  end

  it "turns off light for sub corridor when no movement" do
    hotel.no_movement!(
      floor_identifier: 1,
      sub_corridor_identifier: 2
    )

    floor = hotel.get_floor(floor_identifier: 1)
    expect(floor.get_sub_corridor(sub_corridor_identifier: 2).light.switched_on?).to be_falsey
    expect(floor.get_sub_corridor(sub_corridor_identifier: 1).air_conditioner.switched_on?).to be_truthy
  end
end