require 'gembots'

# The Arena class is used to create and simulate arenas.
class Gembots::Arena
  # This is a hash table containing the ids of each player.
  attr_reader :players

  def initialize *bots
    @players = Hash.new

    # define each bots' update function and add to players hash
    bots.each do |bot|
      bot.arena = self
      @players[bot.id] = bot

      def bot.update arena
        arena.update_bot self
      end
    end
  end

  # Used for activating the robot's custom functions based on active events.
  def update_bot robot
    # something here
  end
end
