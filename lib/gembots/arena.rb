require 'gembots'

class Gembots::Arena < Gosu::Window
  attr_reader :bots
  def initialize *bots
    super 640, 480, false
    self.caption = "Gembots battle"
    @bots = []

    bots.each do |bot_class|
      bot = bot_class.new self
      bot.warp 320, 240
      @bots << bot
    end
  end

  def draw
    @bots.each &:draw
  end

  def update
    @bots.each &:update
    @bots.each do |bot|
      if bot.actions.empty?
        bot.on_idle
      end
    end
  end

  def button_down id
    close if id == Gosu::KbEscape
  end
end
