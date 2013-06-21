require 'test/unit'
require 'gembots'
require 'gembots/arena'
require 'gembots/bot'

class ArenaTest < Test::Unit::TestCase
  def test_has_bot
    bot = Gembots::Robot.new
    arena = Gembots::Arena.new bot
    assert_equal bot, arena.objects[bot.id]
  end

  def test_board_movement
    bot   = Gembots::Robot.new
    arena = Gembots::Arena.new bot
    bot.turn 90
    bot.move 1
    assert_equal bot.id, arena.board[1][0][0]
  end
end
