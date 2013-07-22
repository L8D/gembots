require 'gembots'

class Gembots::Robot
  attr_reader :x, :y, :angle, :actions

  def initialize window
    @actions = []
    @window = window
    @images = Gosu::Image::load_tiles(window, "media/tank.png", 32, 32, false)
    @image = Gosu::Image.new window, "media/cannon.png", false
    @x = @y = @angle = @cur_image = 0.0
  end

  def warp x, y
    @x, @y = x, y
  end

  def turn angle=10
    @actions << [:turn, angle]
  end

  def move dist=10
    @actions << [:move, dist]
  end

  def update
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

      @actions[0][1] -= 0.5
      @actions.shift if @actions[0][1] == 0.0

    when :turn then
      deg = @actions[0][1] <= 9 ? @actions[0][1] : 10

      @angle += deg
      @angle %= 360
      @actions[0][1] -= deg

      @actions.shift if @actions[0][1] == 0
    end
  end

  def draw
    @images[@cur_image].draw_rot @x, @y, 1, @angle - 90 % 360
    @image.draw_rot @x, @y, 1, @angle - 90 % 360
  end
end
