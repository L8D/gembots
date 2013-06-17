#!/usr/bin/env ruby
require_relative "gembots/custom.rb"
include CustomRobot

ralf = Robot.new

ralf.idle = Proc.new do |robot|
  robot.turn
  robot.move 4
end

ralfy = ralf.clone

ralf.name = "Ralf"
