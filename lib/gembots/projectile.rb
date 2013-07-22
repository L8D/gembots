require 'gembots'

class Gembots::Projectile
  attr_reader :x, :y, :angle

  def initialize window, x=0, y=0, angle=0
    @window = window
    @image = Gosu::Image.new @window, "media/projectile.png", false
    @angle = angle
    @x = x + Gosu::offset_x(@angle, 10)
    @y = y + Gosu::offset_y(@angle, 10)
  end

  def update
    @x += Gosu::offset_x @angle, 2
    @y += Gosu::offset_y @angle, 2
    @x %= 640
    @y %= 480
  end

  def draw
    @image.draw_rot @x, @y, 1, @angle - 90 % 360
  end
end
