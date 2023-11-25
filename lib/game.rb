# frozen_string_literal: true

require_relative 'display'
require_relative 'player'

# Game motor
class Game
  include DisplayText

  def initialize
    @word = select_word
    @player = Player.new
    @mistakes = []
  end

  private

  attr_reader :word, :player, :mistakes

  def play_round(tries, result)
    display_ask_input
    guess = player.recive_guess(word)
    result, tries = check_guess(guess, result, tries)
    display_round_results(tries, mistakes, result)
    [result, tries]
  end

  def check_guess(guess, result, tries)
    return check_letter(guess, result, tries) if guess.length == 1

    check_word(guess, result, tries)
  end

  def check_letter(guess, result, tries)
    index = [*0...word.length].filter { |indx| word[indx] == guess }
    if index.empty?
      mistakes.append(guess) unless mistakes.include?(guess)
      tries -= 1
    else
      index.each { |indx| result[indx] = guess }
    end
    [result, tries]
  end

  def check_word(guess, result, tries)
    return [word.split(''), tries] if guess == word

    [result, tries - 1]
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
