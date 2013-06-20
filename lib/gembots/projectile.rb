require 'gembots'

class Gembots::Projectile
  # String contiaining projectile's type(exa. 'bullet').
  attr_accessor :type

  # X position relative to the arena.
  attr_reader   :x_pos

  # Y position relative to the arena.
  attr_reader   :y_pos

  # Number between 0 and 360 representing the projectile's current facing angle.
  attr_reader   :angle

  # This is simply the projectile's player ID, just like the Robot class
  # It is typically the Object ID, but may be changed to fit other uses.
  attr_reader   :id

  # This is the ID of the origin of the projectile. Usually is the robot that fired it, or the arena.
  # Otherwise the value will be nil.
  attr_accessor :parent_id

  # This is set and used by the arena, if there is one.
  attr_accessor :arena

  def initialize type, par = nil, x = 0, y = 0, ang = 0
    @type            = type

    @x_pos           = x
    @y_pos           = y
    @angle           = ang

    @id              = self.object_id
    @parent_id       = par
  end

  # Moves projectile forward along it's angle for the distance specified.
  # To move backward just use a negative value.
  # Currently it only supports movement along 8 directions.
  def move dist = 1
    # Eventually some math using rotation_matrix will be here, in order to calculate all 360 directions.
    # For now I'm only implementing 8 directions.
    directions = [
      [1,   0],  #   0
      [1,   1],  #  45
      [0,   1],  #  90
      [-1,  1],  # 135
      [-1,  0],  # 180
      [-1, -1],  # 225
      [0,  -1],  # 270
      [1,  -1]   # 315
    ]
    @y_pos += dist * directions[360 / @angle - 1][0]
    @x_pos += dist * directions[360 / @angle - 1][1]

    self.update @arena
  end

  # Rotates angle in degrees clockwise.
  # To rotate counter-clockwise just use a negative number.
  def turn angle
    @angle += angle

    # Used for wrapping:
    @angle -= 360 if @angle > 360
    @angle += 360 if @angle < 0

    self.update @arena
  end

  # Called whenever projectile collides with another object.
  def when_impact object
  end

  # This function is used by the arena for updates and delays and stuff.
  def update *i
  end
end
