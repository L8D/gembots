require 'gembots'

# useful math functions/methods
class Integer
  def to_radian
    self * (Math::PI / 180.0)
  end
end

def rotation_matrix angle
  cos = Math.cos angle
  sin = Math.sin angle

  return [[cos, -sin], [sin, cos]] unless angle < 0
  return [[cos, sin], [-sin, cos]]
end

class Gembots::Robot
  # robots name
  attr_accessor :name

  # coordinates
  attr_reader   :x_pos
  attr_reader   :y_pos
  attr_reader   :angle

  # robot ids
  attr_reader   :id
  attr_accessor :parent_id # i know it's possible to abuse this

  def initialize name = 'Robot'
    @name            = name

    @x_pos           = 0
    @y_pos           = 0
    @angle           = 0

    @id              = self.object_id
    @parent_id       = nil
  end

  # return duplicate robot with own parent_id
  def clone
    clone = self.dup
    clone.parent_id = self.id
    clone
  end

  # useful information functions
  def is_clone_of? robot
    @parent_id == robot.id
  end

  # moves forward the distance specified
  # use negative numbers to move in reverse
  def move dist=1
    # math stuff here to calculate movement and stuff
    # for now I'll just implement 8 directions
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
  end

  # rotates angle in degrees clockwise
  # use negative numbers to move counter-clockwise
  def turn angle
    @angle += angle

    # wrapping
    @angle -= 360 if @angle > 360
    @angle += 360 if @angle < 0

    # additional code to implement animation speed/timing if need be
    self.update
  end

  # defaults to prevent errors when stuff isn't defined + awesome docs

  # main loop idle code
  # it gets interrupted whenever other functions need to get called
  def when_idle robot
  end

  # angle/view has detected another robot
  def when_find_robot robot, target_robot
  end

  # when moving to the same space as another robot
  def when_robot_collision robot, target_robot
  end

  # function run to tell arena to update their crap
  def update *i
  end
end
