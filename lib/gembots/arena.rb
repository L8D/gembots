require 'gembots'
require 'gembots/projectile'

# Class used for initializing the arena and opening the window.
class Gembots::Arena < Gosu::Window
  # Array containing an instance of each bot in the arena
  attr_reader :bots

  def initialize *bots
    super 640, 480, false
    self.caption = "Gembots battle"
    @bots = []
    @projs = []

    bots.each do |bot_class|
      bot = bot_class.new self
      bot.warp 320, 240
      @bots << bot
    end
  end

  # Method called via Gosu.
  # It simply calls the draw method for each projectile and bot.
  def draw
    @bots.each &:draw
    @projs.each &:draw
  end

  # Method called via Gosu.
  # It calls the update method for each projectile and bot.
  # It also checks to see if a projectile has hit a bot, and deletes the bot and projectile if it has.
  def update
    @bots.each &:update
    @projs.each &:update

    @bots.each do |bot|
      bot.on_idle if bot.actions.empty?

      @projs.each do |proj|
        if (Gosu::distance bot.x, bot.y, proj.x, proj.y) < 10
          @bots.delete bot
          @projs.delete proj
        end
      end
    end
  end

  # Method called via Gosu.
  # If the escape key is pressed, then the window closes.
  def button_down id
    close if id == Gosu::KbEscape
  end

  # Spawns a Projectile instance at bot's position and angle.
  def spawn_proj bot
    @projs << Gembots::Projectile.new(self, bot.x, bot.y, bot.angle)
  end
end
