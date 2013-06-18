#require 'gembots'
# useful math functions/methods

module Gembots
end

class Integer
  def to_radian
    self * (Math::PI / 180.0)
  end
end

def rotation_matrix angle
  cos = Math::cos angle
  sin = Math::sin angle

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

  def initialize name="Robot"
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
  def move dist
    # math stuff here to calculate movement and stuff
  end

  # defaults to prevent errors when stuff isn't defined
  def when_idle *i; end;
  def when_find_robot *i; end;
  def when_robot_collision *i; end;
end
