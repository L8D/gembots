require 'test/unit'
require 'gembots'
require 'gembots/arena'
require 'gembots/bot'

class MyBot1 < Gembots::Robot
  def on_idle
    self.move
    self.turn
  end
end

class MyBot2 < Gembots::Robot
  def on_idle
    self.move 50
    self.turn 180
  end
end

class ArenaTest < Test::Unit::TestCase
  def test_arena_window
    arena = Gembots::Arena.new MyBot1, MyBot2
    arena.show
  end
end
