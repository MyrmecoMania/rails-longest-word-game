class GamesController < ApplicationController
  require 'json'
  require 'open-uri'
  def new
    @letters = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
    @game = []
    10.times do
      @game.push(@letters.sample)
    end
  end

  def score
    @word = params[:word]
    @game = params[:game].split
    @arr = @word.chars
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)
    if (@arr - @game).empty? == false
      @result = "Sorry but #{@word} can't be build out of #{@game}"
    elsif (@arr - @game).empty? == true && user['found'] == false
      @result = "Sorry but #{@word} does not seem to be a valid English word..."
    elsif (@arr - @game).empty? == true && user['found'] == true
      @result = "Congratulations! #{@word} is a valid English word!"
    end
  end
end
