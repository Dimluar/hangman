# frozen_string_literal: true

require_relative 'display'

# Human player
class Player
  include DisplayText

  def receive_load_play
    answer = gets.chomp.downcase.strip
    return answer if %w[play load].include?(answer)

    display_invalid_load_play
    receive_load_play
  end

  def receive_guess(word)
    guess = gets.chomp.downcase.strip
    return guess if guess == '!save'
    return guess if guess == '!quit'

    unless valid_guess_input?(word, guess)
      display_invalid_word
      return receive_guess(word)
    end
    guess
  end

  def receive_name(options)
    id = gets.chomp.strip
    return "saves/slot_#{id}" if options.include?(id)

    display_invalid_id
    receive_name(options)
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
