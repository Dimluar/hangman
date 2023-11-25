# frozen_string_literal: true

require_relative 'display'

# Human player
class Player
  def recive_guess(word)
    guess = gets.chomp.downcase.strip
    unless valid_guess_input?(word, guess)
      display_invalid_word
      return recive_guess(word)
    end
    guess
  end

  private

  def valid_guess_input?(word, guess)
    (guess.length == 1 || guess.length == word.length) && guess.index(/[^[a-z]]/).nil?
  end
end
