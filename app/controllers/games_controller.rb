require 'open-uri'

class GamesController < ApplicationController

  def new
    vowels = %w(A E I O U Y)
    @letters = Array.new(5) {(('A'..'Z').to_a-vowels).sample}
    @letters += Array.new(5) {vowels.sample}
    # raise
  end

  def score
    @letters = params[:letters].split("")
    @word = params[:word]
    @exist = exist?(@word)
    # Grab params from @letters and split
      # @new_array = params["word"].split('')
    # grab word params and check casesensitivity
    # check letter is included in word
    # check word exists in dictionary
    @include = match(@word, @letters)
    @score = 0
    @score = 10
  end

  def exist?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = JSON.parse(URI.open(url).read)
    response['found']
  end

  def match(word, letters)
    word.chars.all? do |letter|
      word.count(letter) <= letters.count(letter)
    end
  end
end
