# Frozen_String_Literal: false

require_relative 'player'
require_relative 'board'

# This class is holds the methods for the main gameplay
class Gameplay
  attr_accessor :player1, :player2
  attr_reader :board

  def initialize
    @board = Board.new
    @player1 = nil
    @player2 = nil
  end

  def play
    puts 'Welcome to Tik-Tac-Toe!'
    customize_players
    player_turn_loop
    share_winner
  end

  def player_customization(number, invalid_marker = nil)
    puts "Hello Player ##{number}, what's is your name?"
    name = $stdin.gets.chomp
    marker = choose_marker(invalid_marker, number)
    Player.new(name, marker, number)
  end

  def choose_marker(taken_marker, number)
    puts "So player ##{number}, what 1 letter or character do you want your game marker to be?"
    marker = $stdin.gets.chomp
    return marker if marker.match?(/\D/) && marker.length == 1 && marker != taken_marker

    puts "Sorry, you can't make that your marker. Try again."
    choose_marker(taken_marker, number)
  end

  def customize_players
    @player1 = player_customization('1')
    @player2 = player_customization('2', @player1.marker)
  end

  def player_turn_loop
    loop do
      player_play(@player1)
      break if @board.gameover?

      player_play(@player2)
      break if @board.gameover?
    end
  end

  def player_play(player_obj)
    @board.show_board
    puts "#{player_obj.name}, enter a number (1-9) that is not already taken by a player marker."
    space_sel = $stdin.gets.chomp
    space_sel = sel_valid_num(space_sel)
    sel_valid_space(space_sel, player_obj)
  end

  def sel_valid_num(selected_num)
    until selected_num.to_i < 10 && selected_num.to_i.positive?
      puts 'Please enter a number (1-9).'
      selected_num = $stdin.gets.chomp
    end
    selected_num
  end

  def sel_valid_space(selected_space, player_obj)
    while @board.space_taken?(selected_space)
      puts 'Please enter a number (1-9) that is not already taken.'
      selected_space = $stdin.gets.chomp
    end
    @board.place_marker(selected_space, player_obj.marker)
  end

  def share_winner
    @board.show_board
    return puts "#{@player1.name} is the winner!" if player1_win?
    return puts "#{@player2.name} is the winner!" if player2_win?

    puts 'Tied Game!'
  end

  def player1_win?
    return true if @board.winner_marker == @player1.marker

    false
  end

  def player2_win?
    return true if @board.winner_marker == @player2.marker

    false
  end
end
