require 'gembots'

# The Arena class is used to create and simulate arenas.
class Gembots::Arena
  # This is a hash table containing the ids of each object.
  attr_reader :objects

  def initialize *bots
    @objects = Hash.new

    # define each bots' update function and add to players hash
    bots.each do |bot|
      bot.arena = self
      @objects[bot.id] = bot

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
  end
end
