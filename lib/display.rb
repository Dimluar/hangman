# frozen_string_literal: true

# Display system
module DisplayText
  def display_round_results(tries, mistakes, word)
    display_figure(tries)
    display_mistakes(mistakes)
    display_word(word)
  end

  private

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
