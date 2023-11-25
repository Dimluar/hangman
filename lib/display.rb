# frozen_string_literal: true

# Display system
module DisplayText
  def display_round_results(tries, mistakes, word)
    display_figure(tries)
    display_mistakes(mistakes)
    display_word(word)
  end

  def self.display_instructions
    puts File.read('instructions.txt')
  end

  def display_play_again
    puts "\nDo you want to play again?"
  end

  def display_load_play
    puts "\nStart new game or load save? (play, load)"
  end

  def display_invalid_load_play
    puts "\nPlease answer with play or load:"
  end

  def display_no_save
    puts "\nCan't load saves, there's none."
  end

  def display_empty_line
    puts "\n"
  end

  def display_game_closed
    puts "\nGOODBYE! See you soon"
  end

  def display_close_game
    puts "\nAny progress not saved will be lost. Do you want to proceed anyways? (yes, no)"
  end

  def display_game_saved
    puts "\nGame saved correctly!"
  end

  def display_load_slots(saved_games)
    puts "\nInput the number of the slot you want to load the game from."
    puts obtain_slots(saved_games)
  end

  def display_save_slots
    puts "\nInput the number of the slot in wich you want to save the game."
    puts SLOTS
  end

  SLOTS = <<~TEXT
     -Slots:
       Slot 1
       Slot 2
       Slot 3

    Number:
  TEXT

  def display_invalid_confirmation
    puts "\nPlease answer with yes or no:"
  end

  def display_file_exist
    puts "\nThis slot already has a saved game. Do you want to overwrite it? (yes, no)"
  end

  def display_invalid_id
    puts "\nPlease input a valid number: (1, 2, 3)"
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
    puts "\nWrite your guess (letter, word) or comman(!save, !quit):"
  end

  def obtain_slots(slots_numbers)
    slots = slots_numbers.map { |number| "Slot #{number}\n" }.join('')
    <<~TEXT
       -Slots:
         #{slots}

      Number:
    TEXT
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
