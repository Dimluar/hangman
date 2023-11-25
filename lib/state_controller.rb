# frozen_string_literal: true

require_relative 'display'

# Saves, loads and closes game
class StateController
  include DisplayText

  def initialize(game, player)
    @game = game
    @player = player
  end

  def save_game
    display_separator
    display_save_slots
    name = player.receive_name
    make_save(name)
    display_separator
    sleep(0.6)
  end

  private

  attr_reader :game, :player

  def make_save(name)
    make_saves_directory
    write_save(name)
  end

  def make_saves_directory
    Dir.mkdir('saves') unless File.directory?('saves')
  end

  def write_save(name)
    if File.exist?(name)
      display_file_exist
      return unless player.receive_confirmation?
    end
    File.write(name, serialize_game)
    display_game_saved
  end

  def serialize_game
    Marshal.dump(game)
  end
end
