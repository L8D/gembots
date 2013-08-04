require 'gembots'

# Class used for initializing the arena and opening the window.
class Gembots::Arena < Gosu::Window
  # Array containing an instance of each bot in the arena
  attr_reader :bots

  def initialize *bots
    super 640, 480, false
    self.caption = "Gembots battle"
    @bots = []
    @projs = []

    bots.each do |bot_proto|
      bot = Gembots::Robot.new self, bot_proto
      bot.warp (rand * 1000).to_i % 640, (rand * 1000).to_i % 480
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
      if bot.actions.empty?
        bot.proto::on_idle bot
        bot.state = :idle
      end

      @projs.each do |proj|
        if (Gosu::distance bot.x, bot.y, proj.x, proj.y) < 15 and proj.parent != bot
          @bots.delete bot
          @projs.delete proj
        else
          if proj.x < 0 or proj.y < 0 or proj.x > 640 or proj.y > 480
            @projs.delete proj
          end
        end
      end

      (@bots.select { |b| b != bot }).each do |o_bot|
        if bot.angle.to_i / 5 == ((Gosu::angle(bot.x, bot.y, o_bot.x, o_bot.y) * 10).to_i / 10 / 5) and bot.state != :scan
          bot.state = :scan
          bot.clear_actions
          bot.proto.on_scan_bot bot, o_bot.clone.freeze
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
    @projs << Gembots::Projectile.new(self, bot.x, bot.y, bot.angle, parent=bot)
  end
end
