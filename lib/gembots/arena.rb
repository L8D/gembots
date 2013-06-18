require 'gembots'

class Gembots::Arena
  attr_reader :players

  def initialize *bots
    # hash table of the ids of every player in the arena
    @players = Hash.new

    bots.each do |bot|
      bot.arena = self
      @players[bot.id] = bot
      def bot.update arena
        arena.update_bot self
      end
    end
  end

  def update_bot robot
    # something here
  end
end
