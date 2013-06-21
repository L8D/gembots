require 'gembots'

# The Arena class is used to create and simulate arenas.
class Gembots::Arena
  # This is a hash table containing the ids of each object.
  attr_reader :objects

  # Same as objects, but it contains and older copy to detect changes during a update_bot.
  attr_reader :objects_pre

  # 2-dimensional array of the current arena.
  # By default this is a 20x20 board
  attr_reader :board

  def initialize *bots
    @objects     = Hash.new
    @objects_pre = Hash.new
    @board       = Array.new 20, (Array.new 20, [])

    # define each bots' update function and add to players hash
    bots.each do |bot|
      bot.arena = self
      @objects[bot.id] = bot
      @objects_pre[bot.id] = bot
      @board[bot.x_pos][bot.y_pos] << bot.id

      def bot.update arena
        arena.update_bot self
      end
    end
  end

  # Used for updating the board based on changes in robot.
  def update_bot robot
    id = robot.id
    # detect movement
    if robot.x_pos != @objects_pre[id].x_pos or robot.y_pos != @objects_pre[id].y_pos
      # set new pos
      @board[robot.x_pos][robot.y_pos] << robot.id
      # remove id from old pos
      @board[@objects_pre[id].x_pos][@objects_pre[id].y_pos].delete robot.id
    end
    # update objects_pre
    @objects_pre[id] = robot
  end

  # Spawn object into board and objects array.
  # Most used for spawning projectiles.
  def spawn object
    @objects[object.id] = object
    @board[object.x_pos][object.y_pos] << object.id
  end
end
