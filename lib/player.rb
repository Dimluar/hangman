# frozen_string_literal: true

require_relative 'display'

# Human player
class Player
  include DisplayText

  def receive_guess(word)
    guess = gets.chomp.downcase.strip
    return guess if guess == '!save'

    unless valid_guess_input?(word, guess)
      display_invalid_word
      return receive_guess(word)
    end
    guess
  end

  def receive_name
    id = gets.chomp.strip
    return "saves/slot_#{id}" if ('1'..'3').include?(id)

    display_invalid_id
    receive_name
  end

  def receive_confirmation?
    answer = gets.downcase.strip
    return answer == 'yes' if %w[yes no].include?(answer)

    display_invalid_confirmation
    receive_confirmation?
  end

  private

  def valid_guess_input?(word, guess)
    (guess.length == 1 || guess.length == word.length) && guess.index(/[^[a-z]]/).nil?
  end
end
