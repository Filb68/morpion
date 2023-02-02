require 'bundler'
require 'pry'


require_relative 'lib/application'
require_relative 'lib/board'
require_relative 'lib/boardcase'
require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/show'

game = Game.new  		 
 game.play_game
