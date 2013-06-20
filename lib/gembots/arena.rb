require 'gembots'

# The Arena class is used to create and simulate arenas.
class Gembots::Arena
  # This is a hash table containing the ids of each object.
  attr_reader :objects

  # 2-dimensional array of the current arena.
  # By default this is a 20x20 board
  attr_reader :board

  def initialize *bots
    @objects = Hash.new
    @board   = Array.new 20, (Array.new 20, [])

    # define each bots' update function and add to players hash
    bots.each do |bot|
      bot.arena = self
      @objects[bot.id] = bot
      @board[bot.x_pos][bot.y_pos] << bot.id

      def bot.update arena
        arena.update_bot self
      end
    end
  end

  # Used for activating the robot's custom functions based on active events.
  def update_bot robot
    # something here
  end

  def spawn object
    @objects[object.id] = object
    @board[object.x_pos][object.y_pos] << object.id
  end
end
