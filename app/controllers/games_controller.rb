class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  def new
    @letters = ('A'..'Y').to_a.sample(10)
    @start_time = Time.now
  end

  def in_grid?(guess, letters)
    guess.upcase.chars.all? { |letter| letters.split(' ').count(letter) >= guess.upcase.chars.count(letter) }
  end

  def english_word?(guess)
    @url = "https://wagon-dictionary.herokuapp.com/#{guess}"
    @answer_serialized = URI.open(@url).read
    @answer = JSON.parse(@answer_serialized)
    @answer["found"]
  end

  # def compute_score(guess, letters, start_time, end_time)
  #   # TODO: runs the game and return detailed hash of result (with `:score`, `:message` and `:time` keys)
  #   if in_grid?(guess, letters) && english_word?(guess)
  #     (guess.length * 10) - (end_time - start_time)
  #   else
  #     0
  #   end
  # end

  def score
    @guess = params[:guess]
    @letters = params[:letters]
    @start_time = params[:strat_time]
    @end_time = Time.now
    @is_in_grid = in_grid?(@guess, @letters)
    @is_english_word = english_word?(@guess)
    # @score = compute_score(@guess, @letters, @start_time, @end_time)
  end
end
