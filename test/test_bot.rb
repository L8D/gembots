require 'test/unit'
require 'gembots/custom'

class BotTest < Test::Unit::TestCase
  def test_name
    test_bot = Gembots::Robot.new
    test_bot.name = "test"
    assert_equal "test",
      test_bot.name
  end

  def test_position
    test_bot = Gembots::Robot.new
    test_bot.turn 2
    test_bot.move 5
    assert_equal 5,
      test_bot.x_pos
  end
end
