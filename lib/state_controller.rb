# frozen_string_literal: true

require_relative 'display'

# Saves, loads and closes game
class StateController
  include DisplayText

  attr_reader :game

  def initialize(game, player)
    @game = game
    @player = player
  end
end
