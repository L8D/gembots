require 'test/unit'
require 'gembots/custom'

def make_bot
  bot = Gembots::Robot.new
  bot.name = "test"
  bot.turn 2
  bot.move 5
  bot
end

class BotTest < Test::Unit::TestCase
  def test_name
    bot = make_bot
    assert_equal "test", bot.name
  end

  def test_position
    bot = make_bot
    assert_equal 5, bot.x_pos
  end

  def test_clone
    bot = make_bot
    bot_clone = bot.clone
    assert_equal bot_clone.parent_id, bot.id
  end

  def test_id
    bot = make_bot
    assert_equal bot.object_id, bot.id
  end
end
