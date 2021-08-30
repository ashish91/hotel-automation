class DefaultStateCommand
  attr_reader :floors, :main_corridors, :sub_corridors

  def initialize
    @floors = 0
    @main_corridors = 0
    @sub_corridors = 0
  end

  def parse_line(line)
    tokens = line.split(',').map(&:strip)
    tokens.each do |v|
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
  end
end