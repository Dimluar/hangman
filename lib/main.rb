# frozen_string_literal: true

require_relative 'game'

def start(replay)
  game = replay ? Game.new.play_again : Game.new.start_game
  game.play
  start(true)
end

start(false)
