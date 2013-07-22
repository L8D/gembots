require 'gembots'

# Class used for creating a robot.
class Gembots::Robot
  # X and Y positions
  attr_reader :x, :y

  # Current angle of robot.
  attr_reader :angle

  # Array containing arrays that represent actions that need to be completed.
  # The format is like: `[[:move, 10], [:turn, 90]]`, meaning the robot will move 10 forward, then turn 90 degrees clockwise.
  attr_reader :actions

  attr_reader :cooloff

  # Creates a new instance of the robot.
  def initialize window
    @cooloff = 0
    @warped = false
    @actions = []
    @window = window
    @images = Gosu::Image::load_tiles(window, "#{Gembots::MEDIA}/tank.png", 32, 32, false)
    @image = Gosu::Image.new window, "#{Gembots::MEDIA}/cannon.png", false
    @x = @y = @angle = @cur_image = 0.0
  end

  # Method called via the arena.
  # Warps the robot to the position specified.
  def warp x, y
    @x, @y = x, y unless @warped
    @warped = true
  end

  # Appends a turn action to the actions array.
  # The update method will turn the robot clockwise for the degree specified.
  # If the degree is not specified, it defaults to 10.
  # Use a negative value to rotate counter-clockwise.
  def turn angle=10
    @actions << [:turn, angle]
  end

  # Appends a move action to the actions array.
  # The update method will move the robot forward the distance specified.
  # If the distance is not specified, it defaults to 10.
  # Use a negative value to move in reverse.
  def move dist=10
    @actions << [:move, dist]
  end

  # Method called via the arena.
  # This attempts to preform the first action in the actions array.
  # If it finishes the action, it will pop that actions from the actions array, allowing it to preform the next.
  def update
    @cooloff -= 1 unless @cooloff == 0
    return if @actions.empty?
    case @actions[0][0]
    when :move then
      # I probably should implement dist = @actions[0][1]; dist %= 0.5 or something
      # but right now I'm tired, and worried I will screw up the math if I try that...
      dist = @actions[0][1] <= 0.9 ? @actions[0][1] : 1.0
      @x += Gosu::offset_x @angle, dist
      @y += Gosu::offset_y @angle, dist
      @x %= 640
      @y %= 480

      @cur_image += 0.1
      @cur_image %= 7.0

      @actions[0][1] -= dist
      @actions.shift if @actions[0][1] == 0.0

    when :turn then
      deg = @actions[0][1] <= 9 ? @actions[0][1] : 10

      @angle += deg
      @angle %= 360
      @actions[0][1] -= deg

      @actions.shift if @actions[0][1] == 0

    when :fire
      if @cooloff == 0
        @window.spawn_proj self
        @cooloff = 30
        @actions.shift
      end
    end
  end

  # Method called via the arena.
  def draw
    @images[@cur_image].draw_rot @x, @y, 1, @angle - 90 % 360
    @image.draw_rot @x, @y, 1, @angle - 90 % 360
  end

  # Appends a fire action to the actions array.
  # The update method will call the arena's spawn_proj method.
  def fire amount=1
    amount.times { @actions << [:fire] }
  end
end
