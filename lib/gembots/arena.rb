require 'gembots'
require 'gembots/projectile'

class Gembots::Arena < Gosu::Window
  attr_reader :bots
  attr_reader :arena
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

  def draw
    @bots.each &:draw
    @projs.each &:draw
  end

  def update
    @bots.each &:update
    @bots.each do |bot|
      bot.on_idle if bot.actions.empty?
      @projs.each do |proj|
        if (Gosu::distance bot.x, bot.y, proj.x, proj.y) < 10
          @bots.delete bot
          @projs.delete proj
        end
      end
    end

    @projs.each &:update
  end

  def button_down id
    close if id == Gosu::KbEscape
  end

  def spawn_proj bot
    @projs << Gembots::Projectile.new(self, bot.x, bot.y, bot.angle)
  end
end
