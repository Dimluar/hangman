# frozen_string_literal: true

# Display system
module DisplayText
  def display_round_results(tries, mistakes, word)
    display_figure(tries)
    display_mistakes(mistakes)
    display_word(word)
  end

  def display_separator
    puts '__________________________________________________________________'
  end

  def display_lose_game(word)
    puts "\nYOU LOSE! The correct word was \e[34m#{word}\e[0m!"
  end

  def display_win_game
    puts "\nYOU WIN! CONGRATS!"
  end

  def display_invalid_word
    puts "\nIntroduce a letter or a word with correct length:"
  end

  def display_ask_input
    puts "\nWrite your guess (letter or word):"
  end

  def display_mistakes(mistake_list)
    puts " > Mistakes: #{mistake_list.join(', ')}"
  end

  def display_word(letter_arr)
    puts " > #{letter_arr.join(' ')}"
    puts ''
  end

  def display_figure(tries)
    puts save_figure_library[tries]
  end

  def read_figure_states
    File.read('figure.txt').split('nl')
  end

  def save_figure_library
    count = 7
    read_figure_states.each_with_object({}) do |state, library|
      library[count] = state
      count -= 1
    end
  end
end
