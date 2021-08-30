class Motion
  MOTIONS = { no_movement: 0, movement: 1 }.freeze

  def initialize
    @state = MOTIONS[:no_movement]
  end

  def movement!
    @state = MOTIONS[:movement]
  end

  def no_movement!
    @state = MOTIONS[:no_movement]
  end

  def movement?
    @state == MOTIONS[:movement]
  end
end