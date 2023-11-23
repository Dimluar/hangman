# frozen_string_literal: true

# Game motor
class Game
  def initialize
    @word = select_word
  end

  private

  attr_reader :word

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
