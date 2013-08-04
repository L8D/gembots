require 'test/unit'
require 'gembots'

Bot1 = Module.new do
  def self.on_idle bot
    bot.move 50
    bot.turn 360
    bot.turn 90
  end

  def self.on_scan_bot bot, e_bot
    bot.fire
  end
end

Bot2 = Module.new do
  def self.on_idle bot
    bot.turn 180
    bot.move 50
  end

  def self.on_scan_bot bot, e_bot
    bot.fire
  end
end

class ArenaTest < Test::Unit::TestCase
  def test_arena_window
    arena = Gembots::Arena.new Bot1, Bot2
    arena.show
  end
end
