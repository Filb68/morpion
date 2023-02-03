
  require 'bundler'
require 'pry'


require_relative 'application'
require_relative 'board'
require_relative 'boardcase'
# require_relative 'game'
require_relative 'player'
require_relative 'show'


class Game   		

    @@turn_count = 1
    @@winner = '  '
  
    def initialize				
      puts 'joueur 1- entre ton nom de guerre!'
      @player_one_name = gets.chomp
      puts 'joueur 2 - choisis ton nom, aussi!'
      @player_two_name = gets.chomp
     @board = Array.new(3) { Array.new(3, '_') } 
    end
  
            # blank board showing in console0 1
    def display_board(board)
      puts "\r"
      puts "#{board[0][0]} | #{board[0][1]} | #{board[0][2]}"
      puts "#{board[1][0]} | #{board[1][1]} | #{board[1][2]}"
      puts "#{board[2][0]} | #{board[2][1]} | #{board[2][2]}"
      puts "\r"
    end
  
    def player_turn(turn)
      if turn.odd?
        player_choice(@player_one_name, 'O')
      else
        player_choice(@player_two_name, 'X')
      end
    end
  
    def player_choice(player, symbol)
      puts "#{player} please, entre des coordonnées entre 0 et 2 ... séparées par un espace!"
      input = gets.chomp
      input_array = input.split
      coord_one = input_array[0].to_i
      coord_two = input_array[1].to_i
  
              # loop until the user input is valid - has space, between 0 and two, board slot is free
      until input.match(/\s/) && coord_one.between?(0, 2) && coord_two.between?(0, 2) && @board[coord_one][coord_two] == '_'
        puts "Please, choisi des coordonnées valide pour placer ton pion sur une case libre (entre 0 et 2, on a dit)"
        input = gets.chomp
        input_array = input.split
        coord_one = input_array[0].to_i
        coord_two = input_array[1].to_i
      end
  
      add_to_board(coord_one, coord_two, symbol)
      end
  
  
    def add_to_board(coord_one, coord_two, symbol)
      @board[coord_one][coord_two] = symbol
      @@turn_count += 1
    end
  
            # check 3 across
    def three_across  
      @board.each do |i|
        if i.all? { |j| j == 'X' }
          @@winner = 'X'
          @@turn_count = 10
        elsif i.all? { |j| j == 'O' }
          @@winner = 'O'
          @@turn_count = 10
        else
          nil
        end
      end
    end
            # check 3 down
    def three_down
      flat = @board.flatten
      flat.each_with_index do |v, i|
        if v == 'X' && flat[i + 3] == 'X' && flat[i + 6] == 'X'
          @@winner = 'X'
          @@turn_count = 10
        elsif v == 'O' && flat[i + 3] == 'O' && flat[i + 6] == 'O'
          @@winner = 'O'
          @@turn_count = 10
        else
          nil
        end
      end
    end
  
            # check diagonal
    def three_diagonal
      center_val = @board[1][1]
      if center_val == 'X' || center_val == 'O'
        if @board[0][0] && @board[2][2] == center_val
          @@winner = center_val
          @@turn_count = 10
        elsif @board[2][0] && @board[0][2] == center_val
          @@winner = center_val
          @@turn_count = 10
        end
      else
        nil
      end
    end
  
    def declare_result(symbol)
      case symbol
      when 'O'
        puts "#{@player_one_name} gagne!"
      when 'X'
        puts "#{@player_two_name} arrache la victoire!"
      else
        puts "It's a tie!"
      end
    end
  
    def play_game				
      puts "\r\n"
      puts 'Voilà la chose'
      display_board(@board)
  
      until @@turn_count >= 10 do
        player_turn(@@turn_count)
        three_across
        three_down
        three_diagonal
        display_board(@board)
      end
  
      declare_result(@@winner)
    end
  
  end                          
  
  
  # instructions			(Affichage initial à l'écran)
  
  puts 'Bienvenue au jeu du Morpion.'
  puts "Quand vient ton tour, entre des coordonnées enter 0 et 2 séparées d'un espace"
  puts "\r\n"
  puts '0 0 | 0 1 | 0 2'
  puts '1 0 | 1 1 | 1 2'
  puts '2 0 | 2 1 | 2 2'
  puts "\r\n"
  
