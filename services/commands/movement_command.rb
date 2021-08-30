class MovementCommand
    attr_accessor :movement, :floor, :sub_corridor

    def initialize
      @movement = 0
      @floor = 0
      @sub_corridor = 0
    end

    def parse_line(line)
      tokens = line.split(',').map(&:strip)
      tokens.each do |v|
        attribute, val = v.split(':').map(&:strip)
        case attribute
        when "Movement"
          @movement = val.to_i
        when "Floor"
          @floor = val.to_i
        when "Sub Corridor"
          @sub_corridor = val.to_i
        end
      end
    end

    def movement?
      @movement == 1
    end
  end