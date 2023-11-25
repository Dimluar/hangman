# frozen_string_literal: true

require_relative 'display'
require 'yaml'

# Saves, loads and closes game
class StateController
  include DisplayText

  def initialize(game, player)
    @game = game
    @player = player
  end

  def start_game
    display_separator
    display_load_play
    todo = player.receive_load_play
    return load_game if todo == 'load'

    Game.new
  end

  def save_game
    display_separator
    display_save_slots
    name = player.receive_name('1'..'3')
    make_save(name)
    display_separator
    sleep(0.6)
  end

  def close_game
    display_separator
    display_close_game
    exit_game(false)
    display_separator
  end

  def exit_game(end_game)
    return if !end_game && !player.receive_confirmation?

    display_separator
    display_game_closed
    display_separator
    display_empty_line
    exit
  end

  private

  attr_reader :game, :player

  def load_game
    return no_saves unless exist_saves?

    saved_games = existing_saves
    slots_numbers = obtain_slot_number(saved_games)
    display_load_slots(slots_numbers)
    name = player.receive_name(slots_numbers)
    read_save(name)
  end

  def read_save(name)
    deserialize_game(File.read(name))
  end

  def obtain_slot_number(saved_games)
    saved_games.map { |file| file[-1] }
  end

  def exist_saves?
    !Dir.exist?('saves') || Dir.empty?('saves') ? false : true
  end

  def no_saves
    display_no_save
    sleep(0.6)
    start_game
  end

  def existing_saves
    Dir.entries('saves').filter { |file| file[0] == 's' }
  end

  def deserialize_game(file)
    YAML.safe_load(file, permitted_classes: [Game, Player, StateController], aliases: true)
  end

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
    game.to_yaml
  end
end
