require 'gembots'

class Gembots::Arena
  def initialize *bots
    bots.each do |bot|
      bot.arena = self
      def bot.update arena
        arena.update_bot self
      end
    end
  end

  def update_bot robot
    # something here
  end
end
