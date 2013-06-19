require 'gembots'

# The Robot class is used to create and define robots.
class Gembots::Robot
  # String contained the robot's name.
  # This will typically used for things like announcements during battles.
  attr_accessor :name

  # X position relative to the arena.
  attr_reader   :x_pos

  # Y position relative to the arena.
  attr_reader   :y_pos

  # Number between 0 and 360 representing the robot's current facing angle.
  attr_reader   :angle

  # This is simply the robot's player ID.
  # It is typically the Object ID, but may be changed to fit other uses.
  attr_reader   :id

  # This is the ID of a cloned robot's parent.
  # Otherwise if the robot is not a cloned one, the value will be nil.
  attr_accessor :parent_id

  # This is set and used by the current robot's arena, if there is one.
  attr_accessor :arena

  def initialize name = 'Robot'
    @name            = name

    @x_pos           = 0
    @y_pos           = 0
    @angle           = 0

    @id              = self.object_id
    @parent_id       = nil
  end

  # Returns a duplicate robot(clone) with it's own +parent_id+.
  def clone
    clone = self.dup
    clone.parent_id = self.id
    clone
  end

  # Returns true if robot is a clone of target_robot.
  def is_clone_of? target_robot
    @parent_id == target_robot.id
  end

  # Moves the robot forward along it's angle for the distance specified.
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

  # Rotates angle in degrees clockwise
  # To rotate counter-clockwise just use a negative number
  def turn angle
    @angle += angle

    # Used for wrapping:
    @angle -= 360 if @angle > 360
    @angle += 360 if @angle < 0

    self.update @arena
  end

  # These functions are just for documentation and to prevent erros when calling these undefined

  # This is run whenever the game is in idle state.
  # It is likely used as the robot's main loop.
  def when_idle robot
  end

  # This is run whenever another robot is seen within the facing angle.
  # It usually has some code to fire at the target robot.
  # Make sure to check that it is not your robot's clone!
  def when_find_robot robot, target_robot
  end

  # This is run whenever this robot has ended up colliding with another robot.
  def when_robot_collision robot, target_robot
  end

  # This function is used by the arena for updates and delays and stuff.
  def update *i
  end
end
