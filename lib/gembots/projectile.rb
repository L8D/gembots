require 'gembots'

# Class used by the arena to represent a projectile(bullet).
class Gembots::Projectile
  # Positions of the projectile.
  attr_reader :x, :y

  # Angle of the projectile.
  attr_reader :angle

  def initialize window, x=0, y=0, angle=0
    @window = window
    @image = Gosu::Image.new @window, "#{Gembots::MEDIA}/projectile.png", false
    @angle = angle
    @x = x + Gosu::offset_x(@angle, 10)
    @y = y + Gosu::offset_y(@angle, 10)
  end

  # Method called via the arena.
  # Moves the projectile 2 forward.
  def update
    @x += Gosu::offset_x @angle, 2
    @y += Gosu::offset_y @angle, 2
    @x %= 640
    @y %= 480
  end

  # Method called via the arena.
  def draw
    @image.draw_rot @x, @y, 1, @angle - 90 % 360
  end
end
