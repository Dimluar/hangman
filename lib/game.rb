# frozen_string_literal: true

require_relative 'display'
require_relative 'player'
require_relative 'state_controller'

# Game motor
class Game
  include DisplayText

  def initialize
    @player = Player.new
    @controller = StateController.new(self, player)
    @word = select_word
    @mistakes = []
    @tries = 7
    @result = initial_result
  end

  def play
    display_separator
    display_round_results(tries, mistakes, result)
    play_round until end_game?
    game_over
    display_separator
    display_empty_line
  end

  private

  attr_reader :word, :player, :mistakes, :result, :tries, :controller

  def game_over
    display_separator
    sleep(0.7)

    return display_lose_game(word) if tries.zero?

    display_win_game
  end

  def end_game?
    tries.zero? || result.join('') == word
  end

  def initial_result
    Array.new(word.length, '_')
  end

  def play_round
    display_ask_input
    guess = player.receive_guess(word)
    check_guess(guess)
    display_round_results(tries, mistakes, result)
  end

  def check_guess(guess)
    return controller.save_game if guess == '!save'

    return controller.close_game if guess == '!quit'

    return check_letter(guess) if guess.length == 1

    check_word(guess)
  end

  def check_letter(guess)
    index = [*0...word.length].filter { |indx| word[indx] == guess }
    if index.empty?
      mistakes.append(guess) unless mistakes.include?(guess)
      @tries -= 1
    else
      index.each { |indx| result[indx] = guess }
    end
  end

  def check_word(guess)
    if guess == word
      @result = guess.split('')
    else
      @tries -= 1
    end
  end

  def create_array_from_file(file_name)
    array = []
    File.open(file_name, 'r').readlines.each { |line| array.push(line.gsub("\n", '')) }
    array
  end

  def filter_words_between(array, num1, num2)
    array.filter { |word| word.length.between?(num1, num2) }
  end

  def select_word
    dictionary = create_array_from_file('google-10000-english-no-swears.txt')
    dictionary = filter_words_between(dictionary, 5, 12)
    dictionary.sample
  end
end

Game.new.play
